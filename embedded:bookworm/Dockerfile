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
# Embedded
  apt-get install -y \
    arduino-mk avrdude avrdude-doc libusb-1.0-0-dev libusb-1.0-doc && \
# OpenWrt / LEDE
# Using the Image Generator (Image Builder)
# Ref.: https://openwrt.org/docs/guide-user/additional-software/imagebuilder
  apt-get install -y \
    build-essential \
    libncurses-dev \
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
