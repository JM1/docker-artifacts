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

# FREETZ
# References:
#   http://freetz.org/wiki/help/howtos/common/install#NotwendigePakete
#   http://freetz.org/ticket/1145

FROM jm1337/debian-testing-dev

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  echo "installing required packages" && \
  apt-get install -y \
    subversion gcc g++ binutils autoconf automake libtool make bzip2 libncurses5-dev zlib1g-dev flex bison patch texinfo tofrodos gettext pkg-config perl libstring-crc32-perl xz-utils python unzip intltool libacl1-dev libcap-dev \
    && \
  echo "installing suggested packages" && \
  apt-get install -y \
    graphicsmagick patchutils coreutils ecj ruby gawk libusb-dev fastjar git libc6-dev-i386 lib32ncurses-dev gcc-multilib \
    && \
  apt-get clean

# package requirements:
#  automake (>= 1.10)
#  make (>= 3.81)
#  ruby1.8
#  libc6-dev-i386[amd64]
#  lib32ncurses5-dev[amd64]
#  gcc-multilib[amd64]
#
# realpath is part of coreutils since Debian Jessie
# lib32ncurses5-dev is a virtual package provided by lib32ncurses-dev since Debian Buster
