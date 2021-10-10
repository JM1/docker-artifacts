#!/bin/sh
# vim:set tabstop=8 shiftwidth=4 expandtab:
# kate: space-indent on; indent-width 4;
#
# Copyright (c) 2018-2020 Jakob Meng, <jakobmeng@web.de>
#
# {fmt}
#
# NOTE: This script must cope with being called more than once, e.g. by Ansible!
#
# References:
#  https://github.com/fmtlib/fmt

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Please do run as root" >&2
    exit 125
fi

if [ -f /usr/local/src/fmt/build/install_manifest.txt ] &&
    xargs -i test -e '{}' < /usr/local/src/fmt/build/install_manifest.txt; then
    echo "fmt is already installed. Skipping.." >&2
    exit 124
fi

USERNAME=nobody
PREFIX=/usr
export DEBIAN_FRONTEND=noninteractive

apt-get install -y \
    git dpkg-dev gcc make cmake ccache

apt-get clean
update-ccache-symlinks

export PATH="/usr/lib/ccache:$PATH"
export CC=gcc
export CXX=g++

cd /usr/local/src/
if [ ! -e fmt ]; then
    git clone --depth 1 https://github.com/fmtlib/fmt.git
    cd fmt/
else
    cd fmt/
    git pull
fi

if [ ! -e build ]; then
    mkdir build
    chown "$USERNAME" build/
    chmod a+rx build/
fi

cd build/

sudo -u "$USERNAME" cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_INSTALL_PREFIX="$PREFIX" \
    -DFMT_TEST=OFF \
    ..

sudo -u "$USERNAME" make "-j$(nproc)"

make install
