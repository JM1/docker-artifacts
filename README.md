# docker-artifacts

[Debian-based](https://www.debian.org/) [Docker images](https://hub.docker.com/r/jm1337/).

## How to pull images from Docker Hub

```
# get docker-artifacts
git clone --depth 1 https://github.com/JM1/docker-artifacts.git

# pull all images
make docker-pull

# build only e.g. jm1337/debian:testing
(cd debian && make docker-pull)
```

## How to build images locally

Building the docker images requires Docker, Packer, Ansible (>=2.7) and GNU make.

```
# get docker-artifacts
git clone --depth 1 https://github.com/JM1/docker-artifacts.git

# build all images
make

# build only e.g. jm1337/debian:testing
(cd debian && make)
```

## How to push images to Docker Hub

```
# get docker-artifacts
git clone --depth 1 https://github.com/JM1/docker-artifacts.git

# build all images
make

# push all images
make docker-push

# push only e.g. debian:testing
(cd debian && make docker-push)
```
