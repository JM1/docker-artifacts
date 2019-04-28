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

cd /usr/local/src/
git -C /tmp/ clone --depth 1 https://github.com/fmtlib/fmt.git
sudo mv -i /tmp/fmt .
cd fmt/


mkdir build && cd build/
cmake \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_INSTALL_PREFIX="$PREFIX" \
    ..

make -j$(nproc)
sudo make install

exit
