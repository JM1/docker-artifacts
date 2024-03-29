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

FROM registry.salsa.debian.org/salsa-ci-team/pipeline/base:bookworm

ARG DEBIAN_FRONTEND=noninteractive

# Ref.: https://salsa.debian.org/salsa-ci-team/pipeline/-/blob/master/salsa-ci.yml

RUN \
  if [ -f /etc/apt/sources.list ]; then \
    sed -n '/^deb\s/s//deb-src /p' /etc/apt/sources.list > /etc/apt/sources.list.d/deb-src.list; \
  fi

RUN \
  if [ -f /etc/apt/sources.list.d/debian.sources ]; then \
    sed -i 's/^Types: deb$/Types: deb deb-src/' /etc/apt/sources.list.d/debian.sources; \
  fi

RUN apt-get update && \
  apt-get install -y --no-install-recommends ccache fakeroot build-essential && \
  dpkg-reconfigure ccache && \
  rm -rf /var/lib/apt/lists/*

RUN useradd salsaci && \
  mkdir -p /build /cache/.ccache && \
  chown -R salsaci: /cache/.ccache

ENV PATH="/usr/lib/ccache/:${PATH}"
ENV CCACHE_DIR=/cache/.ccache

VOLUME ["/build"]

WORKDIR /build

COPY entrypoint.sh /usr/local/bin/

CMD [ "/usr/local/bin/entrypoint.sh" ]
