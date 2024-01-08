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
  apt-get install -y --no-install-recommends ansible docker.io git make packer && \
  rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/JM1/docker-artifacts.git /build && \
  mkdir /cache && \
  find /build \
    -mindepth 1 -maxdepth 1 -type d -not -path '*/.*' \
    -exec ln -v -s /cache '{}/.cache' \; && \
  mkdir -p /usr/share/ansible/collections && \
  ansible-galaxy collection install -vvv --collections-path /usr/share/ansible/collections \
    --requirements-file "/build/bootstrap-docker:bookworm/requirements.yml"

VOLUME ["/cache"]

WORKDIR /build

ENTRYPOINT ["/usr/bin/make"]
