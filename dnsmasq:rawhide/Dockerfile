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

FROM registry.fedoraproject.org/fedora-minimal:rawhide

# Ref.:
# https://src.fedoraproject.org/rpms/dnsmasq/blob/rawhide/f/dnsmasq.spec

# shadow-utils is required in order to add system user for dnsmasq

RUN microdnf -y update && \
  microdnf -y install shadow-utils dnsmasq && \
  microdnf clean all

VOLUME ["/etc/dnsmasq.d/"]

ENTRYPOINT ["/usr/sbin/dnsmasq"]

CMD ["--keep-in-foreground"]
