# Copyright (c) 2023 Jakob Meng, <jakobmeng@web.de>
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

FROM registry.fedoraproject.org/fedora:rawhide

# NOTE: dnf check-update will signal available package upgrades with an exit code 100.
#       Fix it by pulling an updated base image.

# man-db has man
# procps has ps
# psmisc has killall
# iproute has ip
# bind-utils has dig
# iputils has ping
RUN dnf -y check-update && \
  dnf -y upgrade && \
  dnf -y install \
    bind-utils iproute iputils tcpdump traceroute socat \
    bash-completion fzf htop less man-db patch procps psmisc screen tmux xz vim hostname \
    glibc-langpack-en \
    git git-lfs mercurial myrepos subversion \
    openssh-clients \
    rust cargo rust-analyzer clippy rustfmt \
    gcc gdb clang cmake gcc-g++ \
    python3 python3-pip python3-virtualenv \
    delve golang golang-honnef-tools golang-x-tools-gopls \
    nodejs nodejs-bash-language-server \
    binwalk rst2pdf \
    mkosi \
    && \
  dnf clean all
