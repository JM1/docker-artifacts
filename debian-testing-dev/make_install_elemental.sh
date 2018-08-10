#!/bin/sh
# vim:set tabstop=8 shiftwidth=4 expandtab:
# kate: space-indent on; indent-width 4;
#
# Copyright (c) 2018 Jakob Meng, <jakobmeng@web.de>
#
# Elemental
# References:
#  https://github.com/elemental/Elemental/blob/master/debian/control
#  https://github.com/elemental/Elemental/blob/master/debian/rules
#  http://libelemental.org/documentation/dev/build.html

set -e

if [ "$(id -u)" -eq 0 ]; then 
    echo "Please do not run as root"
    exit 255
fi

PREFIX=/opt/Elemental/
export DEBIAN_FRONTEND=noninteractive

sudo apt-get install -y \
    git dpkg-dev gcc gfortran make cmake ccache libopenmpi-dev libopenblas-dev liblapack-dev libscalapack-mpi-dev \
    libscalapack-openmpi-dev libmetis-dev qtbase5-dev libmpc-dev libqd-dev python-numpy

# libmpc-dev depends on e.g. libgmp-dev and libmpfr-dev
# libmpich-dev is an alternative to libopenmpi-dev
# quadmath.h is part of libgcc-*-dev
# libparmetis-dev is non-free parallel alternative to libmetis-dev,
#  but elemental requires a patched version not available in Debian
# dpkg-dev is required for dpkg-architecture
# coreutils is required for nproc

sudo apt-get clean
sudo update-ccache-symlinks

eval $(dpkg-architecture)
export PATH="/usr/lib/ccache:$PATH"
export CC=gcc
export CXX=g++

cd /var/tmp/
git clone --depth 1 https://github.com/JM1/Elemental.git # https://github.com/elemental/Elemental.git
cd Elemental/

# If either MinSizeRel or RelWithDebInfo are specified, then Elemental falls back to Release mode.
#  Ref.: https://github.com/elemental/Elemental/blob/master/CMakeLists.txt

# auto detection of ScaLAPACK does not work and thus we use MATH_LIBS

# exported cmake targets compute library paths relative to *.cmake files thus 
#  symlinks to elementals cmake folder do not work!

# elemental install dirs must be relative

# disable quadmath.h (EL_DISABLE_QUAD) because it requires a non-standard compiler extension (-std=gnu++11).
#  Ref.: https://github.com/elemental/Elemental/blob/master/include/El/core/limits.hpp#L143

# set minimal possible language level and disable compiler extensions to ease inclusion in own projects
cat << 'EOF' | patch -p0
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

mkdir build && cd build/
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DBINARY_SUBDIRECTORIES=OFF \
    -DEL_USE_QT5=ON \
    -DEL_TESTS=ON \
    -DEL_EXAMPLES=ON \
    -DEL_HYBRID=ON \
    -DINSTALL_PYTHON_PACKAGE=ON \
    -DEL_DISABLE_SCALAPACK=OFF \
    -DEL_DISABLE_PARMETIS=ON \
    -DEL_DISABLE_QUAD=ON \
    -DMATH_LIBS="-lscalapack-openmpi -lflame -llapack -lopenblas" \
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

make -j$(nproc)

sudo make install

# add library search path
# NOTE: Only used at runtime, not linktime!
sudo sh -c "echo '$PREFIX/lib' >> /etc/ld.so.conf.d/Elemental.conf"
sudo ldconfig

cd /tmp/
rm -rf /var/tmp/Elemental

exit




