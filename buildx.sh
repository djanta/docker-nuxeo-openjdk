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

argv arg_sdk '--sdk' "${@:1:$#}"
argv arg_version '--version' "${@:1:$#}"
argv arg_distrib '--distrib' "${@:1:$#}"
argv arg_push '--push' "${@:1:$#}"
argv arg_platform '--platform' "${@:1:$#}"
argv arg_envfile '--env-file' "${@:1:$#}"

# shellcheck disable=SC2206
DISTRIBUTIONS=(${arg_distrib:-centos})

# shellcheck disable=SC2206
PUSH=(${arg_push:-false})

YEAR=$(date -u +'%Y')
MONTH=$(date -u +'%m')

#PLATFORM=${arg_platform:-"linux/386,linux/amd64,linux/arm64"}
#PLATFORM="linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/s390x"
PLATFORM=${arg_platform:-"linux/amd64,linux/arm64"}

ENV_FILE=${arg_envfile:-"./build/.env"}

LTS=$((--YEAR))

# shellcheck disable=SC2034
VERSION_TAG=${LTS}.$((10#$MONTH))

#    --output "type=image,push=${PUSH}" \

for distrib in "${DISTRIBUTIONS[@]}"; do
  docker buildx build \
    --platform "$PLATFORM" \
    --build-arg BUILD_VERSION="${VERSION_TAG}" \
    --build-arg BUILD_HASH=$(git rev-parse HEAD) \
    --build-arg RELEASE_VERSION="$(date -u +'%Y.%m.%d')-${distrib}" \
    --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
    --build-arg BUILD_DISTRIB="${distrib}" \
    --progress auto \
    --no-cache \
    --load \
    --tag djanta/nuxeo-sdk:"${VERSION_TAG}-${distrib}" \
    --file $(pwd)/dockerfiles/${distrib}/Dockerfile ./
done

#docker buildx prune -f -a --verbose
