# Copyright (c) 2020-2021 Jakob Meng, <jakobmeng@web.de>
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

FROM jm1337/debian:bullseye

ARG DEBIAN_FRONTEND=noninteractive

# NOTE: Sync' this package list with https://github.com/JM1/tex-skeleton/blob/master/report/README.md.example
RUN apt-get update && \
  apt-get install -y \
    git git-lfs ssh-client make texlive-full && \
  apt-get purge -y *-doc && \
  rm -rf /var/lib/apt/lists/*
