# How to build Debian packages in a Docker container

First, define this function in your `~/.bash_aliases`:

```sh
# Run throw-away container for building debian packages with read-write access to parent dir of current working dir
docker_run_debian_builder_here() {
    local _args="" _ppwd="" _bwd=""

    # only allow read-write access to directories within $HOME/code/Debian and $HOME/code/salsa.debian.org
    _ppwd="$(readlink -e "$PWD/..")"
    _bwd="$(basename "$PWD")"
    _args="-v '$_ppwd:/build:rw' '--workdir=/build/$_bwd'"

    : "${RELEASE:=bullseye}"
    [ -n "$DEBUG" ] &&  _args+=" -e DEBUG"
    [ -n "$DEBUG_SHELL" ] &&  _args+=" -e DEBUG_SHELL"

    eval docker run --tty --interactive --init --rm \
        --security-opt no-new-privileges $_args \
        "jm1337/debian-builder:$RELEASE"
}
```

Next retrieve sources for the Debian packages you want to build. For example, clone GRUB2 from `salsa.debian.org`:

```sh
git clone https://salsa.debian.org/grub-team/grub.git
```

Finally `cd` into the package source directory and run `docker_run_debian_builder_here`:

```sh
cd grub/
# Build GRUB2 packages for Debian 11 (Bullseye)
RELEASE=bullseye DEBUG=yes DEBUG_SHELL=yes docker_run_debian_builder_here

# Build GRUB2 packages for Debian 12 (Bookworm)
RELEASE=bookworm DEBUG=yes DEBUG_SHELL=yes docker_run_debian_builder_here
```

Find the recently build Debian binary packages in subdirectory `*-build-*` of the parent directory,
e.g. `../grub-build-20220502191516`.
