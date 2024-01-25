#!/bin/bash

# ---------------------------------------------------------------------------
# buildx.sh - This script will be use to provide our platform deployment build.sh architecture
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

# shellcheck disable=SC2001
argv0=$(echo "$0" | sed -e 's,\\,/,g')
basedir=$(dirname "$(readlink "$0" || echo "$argv0")")

case "$(uname -s)" in
  Linux) basedir=$(dirname "$(readlink -f "$0" || echo "$argv0")");;
  *CYGWIN*) basedir=`cygpath -w "$basedir"`;;
esac

lookup() {
  if [[ -z "$1" ]] ; then
    echo ""
  else
    # shellcheck disable=SC2016
    ${AWK} -v "id=$1" 'BEGIN { FS = "=" } $1 == id { print $2 ; exit }' $2
  fi
}

# shellcheck disable=SC2116
# shellcheck disable=SC2006
argv() {
  variable_name="${2}"
  for i in "${@:3:$#}"; do
    option_name=`echo $i | awk -F= '{print $1}'`
    option_value=`echo $i | awk -F= '{print $2}'`
    case ${option_name} in
    "$variable_name")
      eval "$1=\"${option_value:-$(echo "${4}")}\""
    ;;
    esac
  done
}

# shellcheck disable=SC2116
# shellcheck disable=SC2006
exists() {
  variable_name="${2}"
  for i in "${@:3:$#}"; do
    option_name=`echo $i | awk -F= '{print $1}'`
    option_value=`echo $i | awk -F= '{print $2}'`
    case ${option_name} in
    "$variable_name")
      eval "$1=true"
    ;;
    esac
  done
}

argv argdistrib '--os' "${@:1:$#}"
argv argpush '--push' "${@:1:$#}"
argv argplatform '--platform' "${@:1:$#}"
argv argenvfile '--env-file' "${@:1:$#}"
argv argltsid '--lts' "${@:1:$#}"

# shellcheck disable=SC2206
OSLIST=(${argdistrib:-centos})

# shellcheck disable=SC2206
PUSH=(${argpush:-false})

# shellcheck disable=SC2034
PLATFORM=${argplatform:-'linux/amd64, linux/amd64/v2, linux/amd64/v3, linux/arm64, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/mips64le, linux/mips64, linux/arm/v7, linux/arm/v6'}

# shellcheck disable=SC2034
ENV_FILE=${argenvfile:-'./build/.env'}

YEAR=$(date -u +'%Y')
MONTH=$(date -u +'%m')

#LTS=$((--YEAR))
[ -n "$argltsid" ] && LTS=$argltsid || LTS=$YEAR

# shellcheck disable=SC2034
TAG_ID=${LTS}.$((10#$MONTH))
#TAG_ID=${YEAR}.$((10#$MONTH))

#    --output "type=image,push=${PUSH}" \
#    --no-cache \
#    --load \
#    --platform "$PLATFORM" \
#    --output "type=image,push=${PUSH}" \

#Inspecting the current docker buildx environment...
docker context use default

#Inspecting the current docker buildx environment...
docker buildx inspect --bootstrap default

for OS in "${OSLIST[@]}"; do
  TAG=djanta/nuxeo-sdk-${OS}:${TAG_ID}
  docker -D buildx build \
    --build-arg BUILD_VERSION="${TAG_ID}" \
    --build-arg BUILD_HASH=$(git rev-parse HEAD) \
    --build-arg RELEASE_VERSION="$(date -u +'%Y.%m.%d')-${OS}" \
    --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
    --build-arg BUILD_DISTRIB="${OS}" \
    --progress auto \
    --output "type=image,push=${PUSH}" \
    --tag "${TAG}" \
    --file "$(pwd)/dockerfiles/${OS}/Dockerfile" ./
done

#docker buildx prune -f -a --verbose
