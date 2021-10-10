#!/bin/sh
# vim:set tabstop=8 shiftwidth=4 expandtab:
# kate: space-indent on; indent-width 4;
#
# Copyright (c) 2018-2020 Jakob Meng, <jakobmeng@web.de>
#
# Elemental
#
# NOTE: This script must cope with being called more than once, e.g. by Ansible!
#
# References:
#  https://github.com/elemental/Elemental/blob/master/debian/control
#  https://github.com/elemental/Elemental/blob/master/debian/rules
#  http://libelemental.org/documentation/dev/build.html

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Please do run as root" >&2
    exit 125
fi

if [ -f /usr/local/src/Elemental/build/install_manifest.txt ] &&
    xargs -i test -e '{}' < /usr/local/src/Elemental/build/install_manifest.txt; then
    echo "Elemental is already installed. Skipping.." >&2
    exit 124
fi

USERNAME=nobody
PREFIX=/opt/Elemental/
export DEBIAN_FRONTEND=noninteractive

apt-get install -y \
    git dpkg-dev gcc gfortran make cmake ccache libopenmpi-dev libopenblas-dev liblapack-dev \
    libmetis-dev libmpc-dev libqd-dev

# libmpc-dev depends on e.g. libgmp-dev and libmpfr-dev
# libmpich-dev is an alternative to libopenmpi-dev
# quadmath.h is part of libgcc-*-dev
# libparmetis-dev is non-free parallel alternative to libmetis-dev,
#  but elemental requires a patched version not available in Debian
# dpkg-dev is required for dpkg-architecture
# coreutils is required for nproc
# qtbase5-dev is not going to be installed because Qt5 support for Elemental has been disabled below
# python-numpy is not going to be installed because Python support for Elemental has been disabled below

apt-get clean
update-ccache-symlinks

eval "$(dpkg-architecture)"
export PATH="/usr/lib/ccache:$PATH"
export CC=gcc
export CXX=g++

cd /usr/local/src/
if [ ! -e Elemental ]; then
    git clone --depth 1 https://github.com/elemental/Elemental.git
    cd Elemental/
else
    cd Elemental/
    git pull
fi

# If either MinSizeRel or RelWithDebInfo are specified, then Elemental falls back to Release mode.
#  Ref.: https://github.com/elemental/Elemental/blob/master/CMakeLists.txt

# exported cmake targets compute library paths relative to *.cmake files thus 
#  symlinks to elementals cmake folder do not work!

# elemental install dirs must be relative

# disable quadmath.h (EL_DISABLE_QUAD) because it requires a non-standard compiler extension (-std=gnu++11).
#  Ref.: https://github.com/elemental/Elemental/blob/master/include/El/core/limits.hpp#L143

# disable Qt5 because it is not exported and thus builds using Elemental are currently broken,
#  Ref.: https://github.com/elemental/Elemental/pull/275

# disable ScaLAPACK because its usage in Elemental is buggy.
#  Ref.: https://github.com/JM1/hbrs-mpl/commit/65a2b475f0754f3fd3e63e0b065fba5a35abf90a

# disable Python because Elemental only supports Python 2 which will be EOL in the end of 2020
#  Ref.: https://github.com/elemental/Elemental/blob/master/CMakeLists.txt#L114

# set minimal possible language level and disable compiler extensions to ease inclusion in own projects
cat << 'EOF' | patch -p0 --forward --reject-file=- || true
--- CMakeLists.txt.orig 2018-07-27 07:52:10.460430024 +0000
+++ CMakeLists.txt  2018-07-27 08:37:24.809012628 +0000
@@ -12,14 +12,7 @@
 #  which can be found in the LICENSE file in the root directory, or at
 #  http://opensource.org/licenses/BSD-2-Clause
 #
-if(APPLE)
-  # RPATH support for OS X was introduced in this version
-  cmake_minimum_required(VERSION 2.8.12)
-else()
-  # It is likely/possible that this version could be decreased, but this version
-  # was chosen to support the default version of CMake in CentOS 7
-  cmake_minimum_required(VERSION 2.8.11)
-endif()
+cmake_minimum_required(VERSION 3.1)
 
 project(Elemental C CXX)
 set(EL_VERSION_MAJOR 0)
@@ -392,10 +385,11 @@
 # --------------
 include(detect/Fortran)
 
-# Detect C++11
+# Detect C++14
 # ------------
-include(detect/CXX)
-set(CXX_FLAGS "${CXX_FLAGS} ${CXX14_COMPILER_FLAGS}")
+set(CMAKE_CXX_STANDARD 14)
+set(CMAKE_CXX_STANDARD_REQUIRED ON)
+set(CMAKE_CXX_EXTENSIONS OFF)
 
 # Detect MPI
 # ----------

EOF

if [ ! -e build ]; then
    mkdir build
    chown "$USERNAME" build/
    chmod a+rx build/
fi

cd build/

sudo -u "$USERNAME" cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DBINARY_SUBDIRECTORIES=OFF \
    -DEL_USE_QT5=OFF \
    -DEL_TESTS=OFF \
    -DEL_EXAMPLES=OFF \
    -DEL_HYBRID=ON \
    -DINSTALL_PYTHON_PACKAGE=OFF \
    -DEL_DISABLE_SCALAPACK=ON \
    -DEL_DISABLE_PARMETIS=ON \
    -DEL_DISABLE_QUAD=ON \
    -DMATH_LIBS="-lflame -llapack -lopenblas" \
    -DCMAKE_INSTALL_PREFIX="$PREFIX" \
    -DCMAKE_INSTALL_LIBDIR="lib/${DEB_BUILD_MULTIARCH}" \
    -DINSTALL_CMAKE_DIR="lib/${DEB_BUILD_MULTIARCH}/cmake" \
    ..

    #-DCMAKE_C_COMPILER="gcc" \
    #-DCMAKE_CXX_COMPILER="g++" \
    #-DMATH_LIBS=" ... -L/opt/flame/lib/  ... " \
    #-DCMAKE_C_FLAGS=-isystem\ /opt/flame/include \
    #-DCMAKE_CXX_FLAGS=-isystem\ /opt/flame/include \
    #-DCMAKE_EXPORT_NO_PACKAGE_REGISTRY=ON \

sudo -u "$USERNAME" make "-j$(nproc)"

make install

# add library search path
# NOTE: Only used at runtime, not linktime!
echo "$PREFIX/lib/${DEB_BUILD_MULTIARCH}" > /etc/ld.so.conf.d/Elemental.conf
ldconfig
