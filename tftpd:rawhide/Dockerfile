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
# https://src.fedoraproject.org/rpms/tftp/blob/rawhide/f/tftp.spec
# https://salsa.debian.org/ron/tftp-hpa/-/blob/debian/debian/tftpd-hpa.init
# https://manpages.debian.org/unstable/tftpd-hpa/tftpd.8.en.html

RUN microdnf -y update && \
  microdnf -y install tftp-server && \
  microdnf clean all

VOLUME ["/var/lib/tftpboot"]

ENTRYPOINT ["/usr/sbin/in.tftpd"]

CMD ["--foreground", "--verbose", "--secure", "/var/lib/tftpboot"]
