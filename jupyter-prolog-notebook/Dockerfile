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

FROM jupyter/datascience-notebook

# Run interactive (exit with CTRL-C): 
#  docker run --rm          --publish 127.0.0.1:8888:8888 --interactive --tty --name jm1337-jupyter-prolog-notebook jm1337/jupyter-prolog-notebook
#
# Run as deamon:
#  docker run --rm --detach --publish 127.0.0.1:8888:8888 --interactive --tty --name jm1337-jupyter-prolog-notebook jm1337/jupyter-prolog-notebook
#  docker stop jm1337-jupyter-prolog-notebook
#
# Run and login:
#  docker run -ti --rm jm1337/jupyter-prolog-notebook bash
#
# References:
#  https://hub.docker.com/_/httpd/
#  https://docs.docker.com/engine/userguide/networking/
#  https://github.com/madmax2012/jupyterhub-nbgrader-brsu/blob/master/Dockerfile
#  https://github.com/madmax2012/SWI-Prolog-Kernel

ARG DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update && \
  apt-get install -y \
    git swi-prolog && \
  apt-get clean

USER $NB_UID

RUN pip install backports.tempfile && \
  mkdir -p /opt/conda/share/jupyter/kernels/swi/ && \
  cd /tmp/ && \
  git clone --depth 1 https://github.com/madmax2012/SWI-Prolog-Kernel && \
  cd SWI-Prolog-Kernel && \
  mv -i kernel.json swipl_kernel.py /opt/conda/share/jupyter/kernels/swi/ && \
  cd ../ && \
  rm -rf SWI-Prolog-Kernel
