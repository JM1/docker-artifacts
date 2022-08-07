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

# Ref.:
# https://src.fedoraproject.org/rpms/dhcp/blob/rawhide/f/dhcp.spec
# https://git.alpinelinux.org/aports/tree/main/dhcp?h=master

# uid and gid of dhcpd in rawhide is both 177
# Ref.:
# https://src.fedoraproject.org/rpms/dhcp/blob/rawhide/f/dhcp.spec
# https://pagure.io/setup/blob/master/f/uidgid

RUN microdnf -y update && \
  microdnf -y install dhcp-server && \
  microdnf clean all

VOLUME ["/etc/dhcp/"]

ENTRYPOINT ["/usr/sbin/dhcpd"]

CMD ["-4", "-f", "-cf", "/etc/dhcp/dhcpd.conf", "-user", "dhcpd", "-group", "dhcpd", "--no-pid"]
