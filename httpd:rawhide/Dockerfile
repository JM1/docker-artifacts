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
# https://src.fedoraproject.org/rpms/httpd/blob/rawhide/f/httpd.service
# https://src.fedoraproject.org/rpms/httpd/blob/rawhide/f/httpd.spec

# uid and gid of apache in rawhide is both 48
# Ref.:
# https://src.fedoraproject.org/rpms/httpd/blob/rawhide/f/httpd.spec
# https://pagure.io/setup/blob/master/f/uidgid

RUN microdnf -y update && \
  microdnf -y install httpd mod_ssl && \
  microdnf clean all

STOPSIGNAL SIGWINCH

ENTRYPOINT ["/usr/sbin/httpd"]

CMD ["-DFOREGROUND"]
