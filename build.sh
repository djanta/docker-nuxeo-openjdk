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

DIST=${3:-debian}
JDK_VERSION=${1:-8}
JDK_VARIANT=${2:-jdk}
VERSION_PREFIX=$(date -u +'%y.%m')
VERSION_TAG="$VERSION_PREFIX.$JDK_VERSION"
FULL_TAG="$DIST:$VERSION_TAG"
BUILD_VERSION=$(date -u +'%y.%m.%d')-"$JDK_VERSION"

#docker system prune -a -f
#docker image inspect --format='' djanta/nuxeo-server-debian:8.10

docker --debug build -t djanta/nuxeo-sdk-"$FULL_TAG" \
  --build-arg RELEASE_VERSION="$VERSION_TAG" \
  --build-arg BUILD_VERSION="$BUILD_VERSION" \
  --build-arg BUILD_HASH=$(git rev-parse HEAD) \
  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
  --build-arg BUILD_JDK_VERSION="$JDK_VERSION" \
  --build-arg BUILD_JDK_VARIANT="$JDK_VARIANT" \
  --file $(pwd)/dockerfiles/$DIST/Dockerfile .
