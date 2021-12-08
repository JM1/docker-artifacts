#!/bin/sh
# vim:set tabstop=8 shiftwidth=4 expandtab:
# kate: space-indent on; indent-width 4;
#
# Copyright (c) 2020 Jakob Meng, <jakobmeng@web.de>
#
# Build KDevelop from source
#
# NOTE: This script must cope with being called more than once, e.g. by Ansible!
#
# References:
#  http://kfunk.org/2016/02/16/building-kdevelop-5-from-source-on-ubuntu-15-10/
#  https://community.kde.org/Guidelines_and_HOWTOs/Build_from_source

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Please do run as root" >&2
    exit 125
fi

cd /usr/local/src/kdesrc/

# kdesrc-build must be able to find system-provided kde files or else kdevelop build fails with errors like:
#  FAILED: app/plasma/dataengine/plasma-dataengine-kdevelopsessions.json
#  cd /usr/local/src/kdesrc/kdevelop/app/plasma/dataengine && /usr/bin/desktoptojson -i plasma-dataengine-kdevelopsessions.desktop -o /usr/local/src/kdesrc/build/kdevelop/app/plasma/dataengine/plasma-dataengine-kdevelopsessions.json -s plasma-dataengine.desktop
#  Warning: Could not locate service type file kservicetypes5/plasma-dataengine.desktop, tried ("/usr/local/src/kdesrc/.local/share", "/usr/local/share") and ":/kservicetypes5/plasma-dataengine.desktop" ((null):0, (null))
#  About to parse service type file "plasma-dataengine.desktop"
#
# NOTE: Another reason for this error message might be issue #208, which
#       is solved since Docker 18.04 and libseccomp-2.3.3 [1][2].
#       Ref.:
#        [1] https://github.com/docker/for-linux/issues/208
#        [2] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=901062
if [ ! -e .local ]; then
    mkdir .local
    ln -s /usr/share .local/share
fi

# # Workarounds
# [ ! -d ~/.local/share/kservicetypes5/ ] && {
#     mkdir -p ~/.local/share/kservicetypes5/ && \
#     ln -s /usr/share/kservicetypes5/plasma-dataengine.desktop ~/.local/share/kservicetypes5/plasma-dataengine.desktop;
# }
# ln -s /usr/share/kf5/ ~/.local/share/kf5

if [ ! -e kdesrc-build ]; then
    git clone --depth 1 kde:sdk/kdesrc-build
    ln -s /usr/local/src/kdesrc/kdesrc-build/kdesrc-build /usr/local/bin/
else
    (cd kdesrc-build && git pull)
fi

anything_changed=no

# kdev-valgrind is not build here because it does not provide version-targeted branches
# for newer releases than 5.1 (highly outdated), which breaks compatibility to older
# kdevelop/kdevplatform APIs once kdev-valgrind is updated, e.g. commit 3435f36 no
# longer compiles with kdevplatform 5.3 and thus requires an update of kdevelop.

for module in clazy kdevelop-pg-qt kdevelop kdev-php kdev-python; do
    if [ -f "build/$module/install_manifest.txt" ] &&
        cat "build/$module/install_manifest.txt" | xargs -i test -e '{}'; then
        echo "Skipping already installed $module.."
        continue
    fi
    anything_changed=yes
    sudo -u nobody HOME="$HOME" kdesrc-build --debug --no-install "$module"
    (cd build/$module && ninja install)
done

if [ "$anything_changed" = "no" ]; then
    echo "KDevelop is already installed. Skipping.." >&2
    exit 124
fi
