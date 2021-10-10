#!/bin/sh
# vim:set tabstop=8 shiftwidth=4 expandtab:
# kate: space-indent on; indent-width 4;
#
# Copyright (c) 2020 Jakob Meng, <jakobmeng@web.de>
#
# pybind11
#
# NOTE: This script must cope with being called more than once, e.g. by Ansible!
#
# References:
#  https://github.com/pybind/pybind11
#  https://pybind11.readthedocs.io

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Please do run as root" >&2
    exit 125
fi

if [ -f /usr/local/src/pybind11/build/install_manifest.txt ] &&
    xargs -i test -e '{}' < /usr/local/src/pybind11/build/install_manifest.txt; then
    echo "pybind11 is already installed. Skipping.." >&2
    exit 124
fi

USERNAME=nobody
PREFIX=/opt/pybind11/
export DEBIAN_FRONTEND=noninteractive

apt-get install -y \
    git g++ cmake ninja-build ccache # python3-pytest libeigen3-dev libboost-dev

# python3-pytest, libeigen3-dev and libboost-dev are required for tests

apt-get clean
update-ccache-symlinks

eval "$(dpkg-architecture)"
export PATH="/usr/lib/ccache:$PATH"
export CC=gcc
export CXX=g++

cd /usr/local/src/
if [ ! -e pybind11 ]; then
    git clone --depth 1 https://github.com/pybind/pybind11.git
    cd pybind11/
else
    cd pybind11/
    git pull --ff-only
fi

if [ ! -e build ]; then
    mkdir build
    chown "$USERNAME" build/
    chmod a+rx build/
fi

cd build/

# catch2 in only available in Debian 11 (Bullseye), hence we use '-DDOWNLOAD_CATCH=ON' to fetch the lastest one from git

sudo -u "$USERNAME" cmake \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -G Ninja \
    -DDOWNLOAD_CATCH=ON \
    -DPYBIND11_TEST=OFF \
    -DCMAKE_INSTALL_PREFIX="$PREFIX" \
    -DCMAKE_INSTALL_LIBDIR="lib/${DEB_BUILD_MULTIARCH}" \
    -DPYBIND11_CMAKECONFIG_INSTALL_DIR="lib/${DEB_BUILD_MULTIARCH}/cmake/pybind11" \
    ..

sudo -u "$USERNAME" ninja

ninja install

# add library search path
# NOTE: Only used at runtime, not linktime!
echo "$PREFIX/lib/${DEB_BUILD_MULTIARCH}" > /etc/ld.so.conf.d/pybind11.conf
ldconfig
