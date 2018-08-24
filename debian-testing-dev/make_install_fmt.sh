#!/bin/sh
# vim:set tabstop=8 shiftwidth=4 expandtab:
# kate: space-indent on; indent-width 4;
#
# Copyright (c) 2018 Jakob Meng, <jakobmeng@web.de>
#
# {fmt}
# References:
#  https://github.com/fmtlib/fmt

set -e

if [ "$(id -u)" -eq 0 ]; then 
    echo "Please do not run as root"
    exit 255
fi

PREFIX=/usr
export DEBIAN_FRONTEND=noninteractive

sudo apt-get install -y \
    git dpkg-dev gcc make cmake ccache

sudo apt-get clean
sudo update-ccache-symlinks

export PATH="/usr/lib/ccache:$PATH"
export CC=gcc
export CXX=g++

cd /var/tmp/
git clone --depth 1 https://github.com/fmtlib/fmt.git
cd fmt/


mkdir build && cd build/
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$PREFIX" \
    ..

make -j$(nproc)

sudo make install

cd /tmp/
rm -rf /var/tmp/fmt

exit




