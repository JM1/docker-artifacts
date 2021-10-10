#!/bin/sh
# vim:set tabstop=8 shiftwidth=4 expandtab:
# kate: space-indent on; indent-width 4;
#
# Copyright (c) 2018-2020 Jakob Meng, <jakobmeng@web.de>
#
# libflame
#
# NOTE: This script must cope with being called more than once, e.g. by Ansible!
#
# References:
#  https://github.com/flame/libflame/blob/master/docs/libflame/libflame.pdf
#  https://github.com/flame/libflame/blob/master/INSTALL
#  https://github.com/flame/libflame/blob/master/run-conf/run-configure.sh

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Please do run as root" >&2
    exit 125
fi

if [ -e /opt/libflame/include/FLAME.h ] &&
    [ -e /opt/libflame/lib/libflame.a ] &&
    [ -e /opt/libflame/lib/libflame.so ]; then
    echo "FLAME is already installed. Skipping.." >&2
    exit 124
fi

USERNAME=nobody
PREFIX=/opt/libflame
export DEBIAN_FRONTEND=noninteractive

apt-get install -y \
    git dpkg-dev coreutils debhelper gcc ccache gfortran make libopenblas-dev liblapack-dev

# dpkg-dev is required for dpkg-architecture
# coreutils is required for nproc

apt-get clean
update-ccache-symlinks

eval "$(dpkg-architecture)"
export PATH="/usr/lib/ccache:$PATH"
export CC=gcc

cd /usr/local/src/
if [ ! -e libflame ]; then
    # libflame is build in-source, so its directory must be writeable by $USERNAME
    mkdir libflame
    chown -R "$USERNAME" libflame/
    chmod a+rx libflame/
    # build/update-version-file.sh requires full clone for version detection
    sudo -u "$USERNAME" git clone https://github.com/flame/libflame.git
    cd libflame/
else
    cd libflame/
    sudo -u "$USERNAME" make distclean # building again without running clean before results in linker errors
    sudo -u "$USERNAME" git pull
fi

# NOTE: "make install" fails symlinking if PREFIX/inlude dir already exists. It is assumed that $PREFIX/include does not
#       exist, because the build system will maintain this file as a symlink to the specific include associated with the
#       most recently installed build of libflame. Advice: install libflame to its own private directory (such as 
#       $HOME/flame).
#       Ref.: https://github.com/flame/libflame/issues/9

sudo -u "$USERNAME" ./configure \
    --prefix="$PREFIX" \
    --build="$DEB_BUILD_MULTIARCH" \
    --enable-static-build \
    --enable-dynamic-build \
    --disable-lapack2flame \
    --enable-external-lapack-interfaces \
    --enable-supermatrix \
    --enable-multithreading=pthreads \
    --enable-vector-intrinsics=sse \
    --enable-memory-alignment=16 \
    --enable-debug \
    --enable-max-arg-list-hack

# NOTE: LAPACK calls from C code that was generated MATLAB Coder are incompatible to libflame's compatibility layer that
#       maps LAPACK invocations to their corresponding FLAME/C implementations. That's why we use --disable-lapack2flame

# NOTE: make may not be run in parallel to build libflame when option '--enable-max-arg-list-hack' is enabled! 
#       Doing so will result in undefined behavior from ar.
#       Ref.: https://github.com/flame/libflame/blob/master/docs/libflame/libflame.pdf

# libflame's python script build/flatten-headers.py uses Python interpreter 'python' by default which is not available
# e.g. on Debian 11 (Bullseye) or Ubuntu 20.04 LTS (Focal Fossa) by default, hence we search for known python
# interpreters first.
PYTHON=
for pyinterpreter in python python3 python2; do
    if command -v $pyinterpreter >/dev/null; then
        PYTHON=$pyinterpreter
        break
    fi
done

sudo -u "$USERNAME" make "-j$(nproc)" "PYTHON=$PYTHON"

make install

# add library search path
# NOTE: Only used at runtime, not linktime!
echo "$PREFIX/lib" > /etc/ld.so.conf.d/flame.conf
ldconfig

# make libraries known
for f in libflame.so libflame.a; do
    ln -s -f "$PREFIX/lib/$f" "/usr/lib/${DEB_BUILD_MULTIARCH}/$f"
done
