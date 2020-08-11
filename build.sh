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

DIST=${3:-openjdk}
VERSION=${1:-8}
VARIANT=${2:-jdk}
CURRENT=$(date -u +'%y.%m')
TAG="$CURRENT.$VERSION"

#docker system prune -a -f
# docker image inspect --format='' djanta/nuxeo-server-debian:8.10

docker --debug build -t djanta/nuxeo-sdk-$DIST:$TAG \
  --build-arg BUILD_VERSION=$(date -u +'%y.%m') \
  --build-arg BUILD_HASH=$(git rev-parse HEAD) \
  --build-arg RELEASE_VERSION=$(date -u +'%y.%m') \
  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
  --build-arg BUILD_JDK_VERSION="$VERSION" \
  --build-arg BUILD_JDK_VARIANT="$VARIANT" \
  --file $(pwd)/dockerfiles/$DIST/Dockerfile .
