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

FROM registry.fedoraproject.org/fedora-minimal:rawhide

RUN microdnf -y update && \
  microdnf -y install fzf less patch procps screen tmux xz vim hostname && \
  microdnf -y install git git-lfs openssh-clients python3 python3-pip python3-virtualenv && \
  microdnf clean all
