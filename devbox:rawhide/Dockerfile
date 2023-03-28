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

# code has Visual Studio Code
# dbus-x11 has dbus-launch
# man-db has man
# procps has ps
# psmisc has killall
RUN curl -L -o /etc/yum.repos.d/vscode.repo https://packages.microsoft.com/yumrepos/vscode/config.repo && \
  dnf -y check-update && \
  dnf -y upgrade && \
  dnf -y install \
    code dbus-x11 \
    fzf htop less man-db patch procps psmisc screen tmux xz vim hostname \
    git git-lfs openssh-clients \
    rust cargo rust-analyzer \
    gcc gdb clang cmake gcc-g++ \
    python3 python3-pip python3-virtualenv python3-lsp-black python3-lsp-jsonrpc python3-lsp-server \
    golang golang-x-tools-gopls \
    nodejs nodejs-bash-language-server \
    && \
  dnf clean all
