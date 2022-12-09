#!/bin/bash

# ---------------------------------------------------------------------------
# build.sh - This script will be use to provide our platform deployment build.sh architecture
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


####
# Check whether the given command has existed
###
command_exists () {
  command -v "$1" >/dev/null 2>&1;
}

clean_up() { # Perform pre-exit housekeeping
  return
}

error_exit() {
  echo -e "${PROGNAME:-$(echo "$0")}: ${1:-"Unknown Error"}" >&2
  clean_up
  exit ${2:-1}
}

graceful_exit() {
  clean_up
  exit
}

signal_exit() { # Handle trapped signals
  case $1 in
    INT)
      error_exit "Program interrupted by user" ;;
    TERM)
      echo -e "\n$PROGNAME: Program terminated" >&2
      graceful_exit ;;
    *)
      error_exit "$PROGNAME: Terminating on unknown signal" ;;
  esac
}

# shellcheck disable=SC2145
die() {
    ret=${1}
    shift
    # shellcheck disable=SC2059
    printf "${CYAN}${@}${NORMAL}\n" 1>&2
    exit "${ret}"
}

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
DISTRIBUTIONS=(${arg_distrib:-centos corretto})

# shellcheck disable=SC2206
PUSH=(${arg_push:-false})

YEAR=$(date -u +'%Y')
MONTH=$(date -u +'%m')

LTS=$((--YEAR))

# shellcheck disable=SC2034
VERSION_TAG=${LTS}.$((10#$MONTH))

for distrib in "${DISTRIBUTIONS[@]}"; do
  tagv="djanta/nuxeo-sdk:"${VERSION_TAG}-${distrib}""
  docker --debug build -t "${tagv}" \
    --build-arg BUILD_VERSION="${VERSION_TAG}" \
    --build-arg BUILD_HASH=$(git rev-parse HEAD) \
    --build-arg RELEASE_VERSION="$(date -u +'%Y.%m.%d')-${distrib}" \
    --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
    --build-arg BUILD_DISTRIB="${distrib}" \
    --build-arg BUILD_SDK_VERSION="${VERSION_TAG}" \
    --file $(pwd)/dockerfiles/${distrib}/Dockerfile .

  # shellcheck disable=SC2128
  if [ -n "${PUSH}" ] && [ "${PUSH}" == "true" ]; then
    docker push "${tagv}"
  fi
done

#docker buildx prune -f -a --verbose
