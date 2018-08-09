# docker-artifacts

[Debian-based](https://www.debian.org/) [Docker images](https://hub.docker.com/r/jm1337/).

## How to pull images from Docker Hub

```
# get dockerctl
git clone --depth 1 https://gist.github.com/ab8c3beea108ea14a6b8955050f36357.git
export PATH="$PWD/ab8c3beea108ea14a6b8955050f36357/:$PATH"

# get docker-artifacts
git clone --depth 1 https://github.com/JM1/docker-artifacts.git

# pull all images listed in database
dockerctl db_pull docker-artifacts/db.json
```

## How to build images locally

```
# get dockerctl
git clone --depth 1 https://gist.github.com/ab8c3beea108ea14a6b8955050f36357.git
export PATH="$PWD/ab8c3beea108ea14a6b8955050f36357/:$PATH"

# get docker-artifacts
git clone --depth 1 https://github.com/JM1/docker-artifacts.git

# build all images listed in database
dockerctl db_build docker-artifacts/db.json

# build only debian-testing-systemd and debian-testing-dev
dockerctl db_build docker-artifacts/db.json debian-testing-systemd debian-testing-dev

# add date-tags for all images
dockerctl db_add_tag docker-artifacts/db.json $(date +%Y-%m-%d)
```

## How to push images to Docker Hub

```
# get dockerctl
git clone --depth 1 https://gist.github.com/ab8c3beea108ea14a6b8955050f36357.git
export PATH="$PWD/ab8c3beea108ea14a6b8955050f36357/:$PATH"

# get docker-artifacts
git clone --depth 1 https://github.com/JM1/docker-artifacts.git

# edit database and replace user with your Docker ID
vi docker-artifacts/db.json

# build all images listed in database
dockerctl db_build docker-artifacts/db.json

# push all images listed in database
dockerctl db_push docker-artifacts/db.json

# push only debian-testing-systemd and debian-testing-dev
dockerctl db_push docker-artifacts/db.json debian-testing-systemd debian-testing-dev
```
