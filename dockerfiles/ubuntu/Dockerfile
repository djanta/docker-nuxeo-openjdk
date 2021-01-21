# vim:set ft=dockerfile:

ARG BUILD_JDK_VERSION
ARG BUILD_JDK_VARIANT

# hadolint ignore=DL1000,DL3003,SC1035
FROM ubuntu:groovy

# Declaring expected external variable
ARG BUILD_VERSION
ARG RELEASE_VERSION
ARG BUILD_DATE
ARG BUILD_HASH
ARG BUILD_JDK_VERSION
ARG BUILD_JDK_VARIANT

LABEL description="DJANTA.IO Nuxeo SDK image share across all our downstream nuxeo LTS customization"
LABEL version="$RELEASE_VERSION"
LABEL maintainer="DJANTA, LLC <cloud.packager@djanta.io>"
LABEL author="Koffi Stanislas ASSOUTOVI"
LABEL company="DJANTA, LLC"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="djanta/docker-nuxeo-sdk"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vendor="DJANTA, LLC"
LABEL org.label-schema.url="https://djanta.io/"
LABEL org.label-schema.version=$RELEASE_VERSION
LABEL org.label-schema.description="DJANTA.IO Nuxeo SDK image share across all our downstream nuxeo LTS customization."
LABEL org.label-schema.vcs-url="https://github.com/djanta/docker-nuxeo-sdk"
LABEL org.label-schema.vcs-ref=$BUILD_HASH

# Credit: https://packages.ubuntu.com/search?keywords=openjdk
ENV JDK_VERSION=${BUILD_JDK_VERSION:-8}
ENV JDK_NAME=openjdk-${JDK_VERSION}-${BUILD_JDK_VARIANT:-jdk}
ENV JDK_HEADLESS=${JDK_NAME}-headless

ENV IMAGE_MAGICK_MAX_TREAD=1

#ENV TZ 'America/Chicago'
ENV TZ 'GMT+0'

# This prevents us from get errors during apt-get installs as it notifies the
# environment that it is a non-interactive one.
ENV DEBIAN_FRONTEND noninteractive

# GROOVY-BACKPORTS
# We all the focal-backports source as this will give us access to a povray
# package.  Not having to build this package from source great decreases the
# final size of the container.
#RUN \
#  echo "deb http://archive.ubuntu.com/ubuntu groovy-backports main restricted universe multiverse" >> /etc/apt/sources.list


#====================================================================================
# Updates for debconf
# Prevent message 'debconf: unable to initialize frontend: Dialog'
# Prevent message 'debconf: delaying package configuration, since apt-utils is not installed'
#====================================================================================
#RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# testing online: https://hadolint.github.io/hadolint/
# hadolint ignore=SC2155,DL3008,DL3015
RUN \
  set -x \
  && apt-get -y upgrade \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  locales \
  tzdata \
  # Install JDK and JDK HEADLESS
  ${JDK_NAME} \
  ${JDK_HEADLESS} \
	apt-utils \
	apt-transport-https \
	ca-certificates \
	software-properties-common \
	wget \
	curl \
  net-tools \
	gzip \
	unzip \
	zip \
	gnupg2 \
	dirmngr \
	perl \
# https://pypi.org/project/Jinja2/
	python-jinja2 \
	handbrake \
	imagemagick \
	pwgen \
	ffmpeg2theora \
	ffmpeg \
# Not yet available in (ubuntu:bionic) distribution
	ccextractor \
# (ufraw) is now unmaintained since (ubuntu:groovy). Credit: https://askubuntu.com/questions/1241812/how-can-i-get-ufraw-in-ubuntu-20-04
#	ufraw \
# Replacing (ufraw) since it'll not be mainted from (ubuntu:groovy)
  dcraw \
	x264 \
	libreoffice \
	ghostscript \
	exiftool \
	poppler-utils \
	libwpd-tools \
	inotify-tools \
	jq \
	rsync \
  htop

# Configure timezone
RUN \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone

# Purge & remove unnecessary dependencies ....
RUN apt-get purge -y -f --auto-remove \
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

# enabling utf-8 by default
ENV LANG en_US.utf8

WORKDIR /

# vim:set et ts=2 sw=2:
