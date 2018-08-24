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

FROM jm1337/debian-testing-kde-dev

ARG DEBIAN_FRONTEND=noninteractive

# References:
#  http://kfunk.org/2016/02/16/building-kdevelop-5-from-source-on-ubuntu-15-10/
#  https://community.kde.org/Guidelines_and_HOWTOs/Build_from_source

ADD .gitconfig .kdesrc-buildrc /home/devil/

# # Workarounds
# [ ! -d ~/.local/share/kservicetypes5/ ] && { 
#     mkdir -p ~/.local/share/kservicetypes5/ && \
#     ln -s /usr/share/kservicetypes5/plasma-dataengine.desktop ~/.local/share/kservicetypes5/plasma-dataengine.desktop;
# }
# ln -s /usr/share/kf5/ ~/.local/share/kf5

USER devil

RUN mkdir /tmp/kdesrc && \
  cd /tmp/kdesrc && \
  git clone kde:kdesrc-build && \
  cd kdesrc-build && \
  sudo ln -s /tmp/kdesrc/kdesrc-build/kdesrc-build /usr/local/bin/ && \
  kdesrc-build --debug kdevelop-pg-qt kdevelop kdev-php kdev-python kdev-valgrind && \
  rm -rf /tmp/kdesrc && \
  sudo rm /usr/local/bin/kdesrc-build

USER root
