#vim:set ft=dockerfile:

ARG BUILD_JDK_VERSION
ARG BUILD_JDK_VARIANT

# hadolint ignore=DL1000,DL3003,SC1035
FROM openjdk:${BUILD_JDK_VERSION:-8}-${BUILD_JDK_VARIANT:-jdk}-buster

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

ENV DEBIAN_FRONTEND=noninteractive
ENV IMAGE_MAGICK_MAX_TREAD=1

#ENV TZ 'America/Chicago'
ENV TZ 'GMT+0'


ENV USR_HOME=/usr/share

RUN \
  for ctx in "zoneinfo" ; do \
    if [ -d "$USR_HOME/$ctx" ]; then \
      echo "Scanning package directory: $USR_HOME/$ctx"; \
      for file in "$USR_HOME/$ctx"/*; do \
        case $file in \
          *.zip) \
            echo "Installing: $file" \
            && date \
          ;; \
          *) \
            echo "Unsupported: $file" \
          ;; \
        esac \
      done \
    fi \
  done

# testing online: https://hadolint.github.io/hadolint/
# hadolint ignore=SC2155,DL3008,DL3015
RUN \
  set -x \
  && apt-get -y upgrade \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  locales \
  tzdata \
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
	python3-jinja2 \
	python3-jinja2-time \
	handbrake \
	imagemagick \
	pwgen \
	ffmpeg2theora \
	ffmpeg \
	ufraw \
	ccextractor \
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

#RUN dpkg -l

# enabling utf-8 by default
ENV LANG en_US.utf8

WORKDIR /

# vim:set et ts=2 sw=2:
