#!/bin/sh
# vim:set tabstop=8 shiftwidth=4 expandtab:
# kate: space-indent on; indent-width 4;
# shellcheck disable=SC2039
#
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
#

# NOTE: declare local variables first and initialize them later because return code of "local ..." is always 0

set -eu

# Environment variables
DEBUG=${DEBUG:-}
DEBUG_SHELL=${DEBUG_SHELL:-}

if [ "$DEBUG" = "yes" ] || [ "$DEBUG" = "true" ]; then
    set -x
fi

stderr() {
    local _msg
    while read -r _msg
    do
        echo "$_msg" 1>&2
    done
}

error() {
    stderr << ____EOF
ERROR: $*
____EOF
}

warn() {
    stderr << ____EOF
WARN: $*
____EOF
}

if [ "$PWD" = "/" ]; then
    error "cannot build in root"
    exit 255
fi

# Ref.: https://salsa.debian.org/salsa-ci-team/pipeline/-/blob/master/salsa-ci.yml

_pkg_path="$PWD"
_pkg_name="$(basename "$_pkg_path")"
_pkg_parent_path="$(readlink -m "$_pkg_path/..")"
_pkg_build_path="$_pkg_parent_path/${_pkg_name}-build-$(date +%Y%m%d%H%M%S)"

echo "Copying package parent directory into cache directory"
cp -rav --reflink=auto "$_pkg_parent_path" /cache/
chown -v -R salsaci. /cache
cd "/cache/build/$_pkg_name"

echo "Update apt cache"
eatmydata apt-get update

echo "Install package build dependencies"
eatmydata apt-get build-dep --no-install-recommends -y .

echo "Reset ccache stats"
su salsaci -c "ccache -z"

echo "Build package as user salsaci"
if ! su salsaci -c "eatmydata dpkg-buildpackage $*"; then
    error "Build failed"
    if [ "$DEBUG_SHELL" = "yes" ] || [ "$DEBUG_SHELL" = "true" ]; then
        bash
        exit
    fi
    exit 255
fi

echo "Copy build artifacts to output directory $_pkg_build_path"
mkdir -p "$_pkg_build_path"
cd /cache/build/
find /cache/build/ -maxdepth 1 -type f -exec cp -anv --reflink=auto '{}' "$_pkg_build_path/" \; \
  -name "*.build" -or -name "*.buildinfo" -or -name "*.changes" -or -name "*.deb" -or -name "*.dsc" -or -name "*.tar*"

echo "Changing ownership of build directory to "
_owner="$(stat -c '%u.%g' "$_pkg_path")"
chown -v -R "$_owner" "$_pkg_build_path"

echo "Fetch ccache stats"
su salsaci -c "ccache -s"
