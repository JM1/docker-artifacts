# Copyright (c) 2022 Jakob Meng, <jakobmeng@web.de>
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
  apt-get install --no-install-recommends -y \
    python3-libvirt libvirt-clients libvirt-dev && \
  apt-get install -y \
    ansible-core git git-lfs ssh-client ipython3 python3 \
    python3-apt python3-pip python3-virtualenv python3-openstacksdk \
    python3-dev gcc pkg-config && \
  apt-get purge -y *-doc && \
  rm -rf /var/lib/apt/lists/*
