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

FROM debian:testing

ARG DEBIAN_FRONTEND=noninteractive

# libreadline-dev depends on libreadline*
# console-setup config script depends on lsmod which is part of kmod which 
#  again is falsely not a install dependency of console-setup
RUN apt-get update && \
  apt-get install -y \
    dialog libreadline-dev apt-utils kmod inetutils-ping iproute2 && \
  apt-get clean

ADD sources.list.d/*.list /etc/apt/sources.list.d/
RUN [ -f /etc/apt/sources.list ] && rm /etc/apt/sources.list && \
  apt-get update

RUN apt-get install -y \
    sudo systemd-sysv man-db screen vim p7zip-full curl locales locales-all htop bash-completion console-setup \
    keyboard-configuration lshw patch aptitude net-tools && \
  apt-get clean
# resolvconf is not necessary (and indeed does not work) because /etc/resolv.conf is mounted (?) as volume from host

# either install package locales-all or generate locales yourself:
#RUN echo 'locales locales/locales_to_be_generated multiselect     de_DE.UTF-8 UTF-8' | debconf-set-selections && \
#  echo 'locales locales/default_environment_locale      select  de_DE.UTF-8' | debconf-set-selections && \
#  dpkg-reconfigure --frontend=noninteractive locales

# install and disable unattended-upgrades, which is pulled in by various desktop environments like KDE
RUN echo 'unattended-upgrades     unattended-upgrades/enable_auto_updates boolean false' | debconf-set-selections && \
  apt-get install -y \
    unattended-upgrades && \
  apt-get clean

RUN systemctl mask keyboard-setup.service system-getty.slice console-setup.service
# NOTE: systemd-tmpfiles-setup.service is required e.g. for creation of /run/screen directory
# TODO: Mask systemd-remount-fs.service systemd-update-utmp.service systemd-sysusers.service, too?

# mask services that do not make sense in containers
RUN \
  for SVC in \
    NetworkManager.service \
    ModemManager.service \
    avahi-daemon.socket \
    avahi-daemon.service \
    wpa_supplicant.service \
    udisks2.service \
    upower.service \
  ; do \
    systemctl mask $SVC; \
  done

RUN \
  echo 'devil ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/devil && \
  chmod 440 /etc/sudoers.d/devil && \
  chown root:root /etc/sudoers.d/devil && \
  adduser --quiet --disabled-password --gecos '' devil && \
  echo devil:devil | chpasswd && \
  passwd -d devil && \
  (for group in audio video; do adduser devil $group || exit; done) && \
  chown -R devil:devil /home/devil && \
  rm /etc/motd

#USER devil
#ENV HOME /home/devil
#WORKDIR /home/devil
#ENV SHELL /bin/bash

ENV container docker
STOPSIGNAL SIGRTMIN+3

ADD noclear.conf autovt@.service.d/*          /etc/systemd/system/autovt@.service.d/
ADD noclear.conf console-getty.service.d/*    /etc/systemd/system/console-getty.service.d/
ADD noclear.conf container-getty@.service.d/* /etc/systemd/system/container-getty@.service.d/
ADD noclear.conf getty@.service.d/*           /etc/systemd/system/getty@.service.d/
ADD noclear.conf serial-getty@.service.d/*    /etc/systemd/system/serial-getty@.service.d/

ADD prepare-container.d/* /etc/prepare-container.d/
ADD prepare-container.service /lib/systemd/system/
ADD prepare-container /usr/bin/
RUN systemctl enable prepare-container.service

CMD [ "/sbin/init", "--show-status=false" ] #, "--log-target=null" ]
