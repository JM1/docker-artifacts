# Copyright (c) 2018 Jakob Meng, <jakobmeng@web.de>
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

FROM jm1337/debian-testing-systemd

ARG DEBIAN_FRONTEND=noninteractive

ADD preferences.d/*.pref /etc/apt/preferences.d/
ADD sources.list.d/*.list /etc/apt/sources.list.d/
ADD llvm-snapshot.gpg /etc/apt/trusted.gpg.d/

ADD make_install_flame.sh /usr/local/bin/
ADD make_install_elemental.sh /usr/local/bin/

RUN apt-get update && \
  apt-get install -y \
    quilt packaging-dev \
    gdb ccache \
    clang llvm libclang-dev cloc cppcheck indent doxygen \
    cmake extra-cmake-modules google-perftools \
    bzr mercurial git \
    nasm \
    valgrind \
    delta \
    clang-6.0 lldb-6.0 libclang-6.0-dev \
    && \
  apt-get clean

# Workaround for https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=867705
ADD update-ccache-symlinks.patch /usr/local/src/
RUN cat /usr/local/src/update-ccache-symlinks.patch | patch -p0 -d /
RUN update-ccache-symlinks

# ubuntu-dev-tools requires entries in ppa-ubuntu-toolchain-r.list to be uncommented
#
# lldb* packages version-depend on python-lldb-* packages (e.g. lldb-6.0 => python-lldb-6.0), 
#  but python-lldb-* packages conflict with each other (python-lldb-6.0 != python-lldb-4.0).
#  So only one lldb* package version can be installed at a time. lldb depends e.g. on lldb-4.0 which 
#  because of python-lldb-* conflicts with lldb-6.0, so either install lldb or lldb-6.0.

