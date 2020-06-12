# vim:set ft=dockerfile:
FROM debian:stretch-slim

# Declaring expected external variable
ARG BUILD_VERSION
ARG RELEASE_VERSION
ARG BUILD_DATE
ARG BUILD_HASH

LABEL description="DJANTA.IO Nuxeo SDK Base image share across all over any specific nuxeo version distribution"
LABEL version="$BUILD_VERSION"
LABEL maintainer="DJANTA, LLC <team.docker@djanta.io>"
LABEL author="Stanislas Koffi ASSOUTOVI"
LABEL company="DJANTA, LLC"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="djanta/nuxeo-sdk"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vendor="DJANTA, LLC"
LABEL org.label-schema.url="https://djanta.io/"
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.description="DJANTA.IO Nuxeo SDK Base image share across all over any specific nuxeo version distribution"
LABEL org.label-schema.vcs-url="https://github.com/djanta/docker-nuxeo-sdk"
LABEL org.label-schema.vcs-ref=$BUILD_HASH

ARG DEBIAN_FRONTEND
ENV DEBIAN_FRONTEND noninteractive

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.12
ENV FFMPEG_VERSION 4.2.2-3

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

#=====================
# Updates for debconf
# Prevent message 'debconf: unable to initialize frontend: Dialog'
# Prevent message 'debconf: delaying package configuration, since apt-utils is not installed'
#=====================
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# testing online: https://hadolint.github.io/hadolint/

#RUN cat "deb http://www.deb-multimedia.org buster main non-free" >> /etc/apt/sources.list
#RUN cat "deb http://www.deb-multimedia.org buster-backports main" >> /etc/apt/sources.list

# hadolint ignore=SC2155,DL3008,DL3015
RUN set -x \
#  && echo "deb http://www.deb-multimedia.org buster main non-free" >> /etc/apt/sources.list \
#  && cat /etc/apt/sources.list \
#	&& apt-get update -oAcquire::AllowInsecureRepositories=true \
  && apt-get update \
#  && apt-get install -y --no-install-recommends --allow-unauthenticated deb-multimedia-keyring \
  && apt-get install -y --no-install-recommends \
#	&& apt-get dist-upgrade -y \
#	&& apt-get install -y --no-install-recommends --allow-unauthenticated \
  && apt-get install -y --no-install-recommends \
	apt-utils \
	apt-transport-https \
	ca-certificates wget \
	inotify-tools \
  net-tools \
	gzip \
	gnupg2 \
	dirmngr \
	perl \
	handbrake \
	imagemagick \
	pwgen \
	ffmpeg2theora \
	ffmpeg \
	ufraw \
	x264 \
	libreoffice \
	ghostscript \
	exiftool \
	poppler-utils \
	libwpd-tools \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture | awk -F- '{ print $NF }').asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true

#RUN echo "deb http://www.deb-multimedia.org buster main non-free" >> /etc/apt/sources.list \
#  && echo "deb-src http://www.deb-multimedia.org buster main non-free" >> /etc/apt/sources.list \
#  && apt-get update -oAcquire::AllowInsecureRepositories=true \
#  && apt-get install -y --no-install-recommends --allow-unauthenticated deb-multimedia-keyring \
#  && apt-get update -y --no-install-recommends --allow-unauthenticated \
#  && apt-get install -y --no-install-recommends ffmpeg \
#  && ffmpeg -version

## Start: ffmpeg vulnerability fixing: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17542
# Version affected: <= 4.1
# Version Fix: >= 4.2.0
# Fix: https://www.deb-multimedia.org/
# Resolve resource: https://security.gentoo.org/glsa/202003-65
# Debian version list: http://ftp.debian.org/debian/pool/main/f/ffmpeg/ or https://tracker.debian.org/pkg/ffmpeg
#	ffmpeg \
## END
#RUN wget -O ~/deb-multimedia-keyring.deb "http://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb" \
#  && wget -O ~/ffmpeg_${FFMPEG_VERSION}.deb "http://ftp.debian.org/debian/pool/main/f/ffmpeg/ffmpeg_${FFMPEG_VERSION}_$(dpkg --print-architecture | awk -F- '{ print $NF }').deb" \
#  && dpkg -i ~/deb-multimedia-keyring.deb \
#  && dpkg -i ~/ffmpeg_${FFMPEG_VERSION}.deb

# Purge & remove unnecessary dependencies ....
RUN apt-get purge -y -f --auto-remove ca-certificates wget \
    && apt-get autoremove

RUN dpkg -l

# enabling utf-8 by default
ENV LANG en_US.utf8

WORKDIR /

# vim:set et ts=2 sw=2:
