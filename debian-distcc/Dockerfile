# Copyright (c) 2018-2019 Jakob Meng, <jakobmeng@web.de>
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

FROM jm1337/debian-distcc-core:testing

# Allow all incoming requests by default (--allow 0.0.0.0/0) which is supported since 2.10.2cvs!
# Use iptables to restrict connections to the docker daemon!
# References: 
#  https://docs.docker.com/network/iptables/#restrict-connections-to-the-docker-daemon
#  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=207831

EXPOSE 3632

CMD ["/usr/bin/distccd", "--allow", "0.0.0.0/0", "--daemon", "--verbose", "--no-detach"]
