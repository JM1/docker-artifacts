# docker-artifacts

[Debian-based](https://www.debian.org/) [Docker images](https://hub.docker.com/r/jm1337/).

## How to pull images from Docker Hub

```
# get docker-artifacts
git clone --depth 1 https://github.com/JM1/docker-artifacts.git

# pull all images
make docker-pull

# build only e.g. jm1337/debian:bullseye
(cd debian\:bullseye && make docker-pull)
```

## How to build images locally

Building the docker images requires Docker, Packer, Ansible (>=2.9) and GNU make.

```
# get docker-artifacts
git clone --depth 1 https://github.com/JM1/docker-artifacts.git

# build all images
make

# build only e.g. jm1337/debian:bullseye
(cd debian\:bullseye && make)
```

## How to push images to Docker Hub

```
# get docker-artifacts
git clone --depth 1 https://github.com/JM1/docker-artifacts.git

# build all images
make

# push all images
make docker-push

# push only e.g. debian:bullseye
(cd debian\:bullseye && make docker-push)
```

## License

GNU General Public License v3.0 or later

See [LICENSE.md](LICENSE.md) to see the full text.

## Author

Jakob Meng
@jm1 ([github](https://github.com/jm1), [galaxy](https://galaxy.ansible.com/jm1), [web](http://www.jakobmeng.de))
