# Copyright (c) 2024 Jakob Meng, <jakobmeng@web.de>
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

FROM debian:bookworm

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y \
   apt-utils fzf less locales patch procps screen tmux xz-utils vim && \
#
#
#
# Embedded
  apt-get install -y \
    arduino-mk avrdude avrdude-doc libusb-1.0-0-dev libusb-1.0-doc && \
#
#
#
# FREETZ
# Ref.:
# http://freetz.org/wiki/help/howtos/common/install#NotwendigePakete
# http://freetz.org/ticket/1145
  apt-get install -y \
#
# required packages
    subversion \
    gcc \
    g++ \
    binutils \
    autoconf \
    automake \
    libtool \
    libtool-bin \
    make \
    bzip2 \
    libncurses5-dev \
    zlib1g-dev \
    flex \
    bison \
    patch \
    texinfo \
    tofrodos \
    gettext \
    pkg-config \
    perl \
    libstring-crc32-perl \
    xz-utils \
    python3 \
    unzip \
    intltool \
    libacl1-dev \
    libcap-dev \
    bc \
    libreadline-dev \
#
# suggested packages
    graphicsmagick \
    graphicsmagick-imagemagick-compat \
    patchutils \
    coreutils \
    ecj \
    ruby \
    gawk \
    libusb-dev \
    fastjar \
    git \
    libc6-dev-i386 \
    lib32ncurses-dev \
    gcc-multilib \
#
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
    && \
#
#
#
# OpenWrt / LEDE
# Using the Image Generator (Image Builder)
# Ref.: https://openwrt.org/docs/guide-user/additional-software/imagebuilder
  apt-get install -y \
    build-essential \
    libncurses5-dev \
    libncursesw5-dev \
    zlib1g-dev \
    gawk \
    git \
    gettext \
    libssl-dev \
    xsltproc \
    rsync \
    wget \
    unzip \
    python3 \
    && \
  apt-get purge -y *-doc && \
  rm -rf /var/lib/apt/lists/*
