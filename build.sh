#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# docker.sh - This script will be use to provide our platform deployment dockerjs.sh architecture
#
# Copyright 2015, Stanislas Koffi ASSOUTOVI <team.docker@djanta.io>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License at <http://www.gnu.org/licenses/> for
# more details.
# ---------------------------------------------------------------------------

all () {
  echo "Build all ... "
}

#DIST=${3:-debian}
#JDK_VERSION=${1:-8}
JDK_VARIANT=${3:-jdk}
VERSION_SUFFIX=$(date -u +'%y.%m')
#VERSION_TAG="$JDK_VERSION.$VERSION_SUFFIX"
#FULL_TAG="$VERSION_TAG-$DIST"
#BUILD_VERSION=$(date -u +'%y.%m.%d')-"$JDK_VERSION"

#docker system prune -a -f
#docker image inspect --format='' djanta/nuxeo-sdk:8.10-debian

# shellcheck disable=SC2206
distributions=(${1:-debian ubuntu centos fedora opensuse oraclelinux7 rhel})

# shellcheck disable=SC2206
jdkversions=(${2:-8 9 11 12 13 14 15})

for jdkver in "${jdkversions[@]}"; do
  VERSION_TAG="$jdkver.$VERSION_SUFFIX"
  BUILD_VERSION=$(date -u +'%y.%m.%d')-"$jdkver"

  for dist in "${distributions[@]}"; do
    FULL_TAG="$VERSION_TAG-$dist"
    docker --debug build -t djanta/nuxeo-sdk:"$FULL_TAG" \
      --build-arg RELEASE_VERSION="$VERSION_TAG" \
      --build-arg BUILD_VERSION="$BUILD_VERSION" \
      --build-arg BUILD_HASH=$(git rev-parse HEAD) \
      --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
      --build-arg BUILD_JDK_VERSION="$jdkver" \
      --build-arg BUILD_JDK_VARIANT="$JDK_VARIANT" \
      --file $(pwd)/dockerfiles/$dist/Dockerfile .
  done
done

#docker --debug build -t djanta/nuxeo-sdk:"$FULL_TAG" \
#  --build-arg RELEASE_VERSION="$VERSION_TAG" \
#  --build-arg BUILD_VERSION="$BUILD_VERSION" \
#  --build-arg BUILD_HASH=$(git rev-parse HEAD) \
#  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
#  --build-arg BUILD_JDK_VERSION="$JDK_VERSION" \
#  --build-arg BUILD_JDK_VARIANT="$JDK_VARIANT" \
#  --file $(pwd)/dockerfiles/$DIST/Dockerfile .
