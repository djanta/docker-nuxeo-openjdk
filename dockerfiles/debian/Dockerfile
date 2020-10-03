# vim:set ft=dockerfile:

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
ENV JDK_VERSION=${BUILD_JDK_VERSION:-8}
ENV JDK_NAME=openjdk-${JDK_VERSION}-${BUILD_JDK_VARIANT:-jdk}

# grab gosu for easy step-down from root
#ENV GOSU_VERSION 1.12
#ENV FFMPEG_VERSION 4.2.2-3
#ENV JENV 0.5.3

#SHELL ["/bin/bash", "-o", "pipefail", "-c"]

#====================================================================================
# Updates for debconf
# Prevent message 'debconf: unable to initialize frontend: Dialog'
# Prevent message 'debconf: delaying package configuration, since apt-utils is not installed'
#====================================================================================
#RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

##
# The run below intent to solve the follow error:
# SOURCE (https://github.com/geerlingguy/ansible-role-java/issues/64):
#Errors were encountered while processing:
# openjdk-11-jre-headless:amd64
# openjdk-11-jre:amd64
# openjdk-11-jdk-headless:amd64
# openjdk-11-jdk:amd64
# ca-certificates-java
#E: Sub-process /usr/bin/dpkg returned an error code (1)
##
RUN mkdir -p /usr/share/man/man1/

#RUN \
#  # Register latest the security updated source
#  echo "deb http://security.debian.org/debian-security buster/updates main contrib non-free" \
#  #  >> /etc/apt/sources.list
#    >> /etc/apt/sources.list.d/security.list;

###
## Workaround to fix missing this package "ufraw" missing debian (sid) or namely openjdk-9-jdk
###
#RUN \
#  if [ "$JDK_VERSION" == "9" ]; then \
#    echo "deb http://ftp.us.debian.org/debian buster main contrib non-free" >> /etc/apt/sources.list.d/buster.list; \
#    echo "deb-src http://ftp.us.debian.org/debian buster main contrib" >> /etc/apt/sources.list.d/buster.list; \
#  fi

# testing online: https://hadolint.github.io/hadolint/
# hadolint ignore=SC2155,DL3008,DL3015
RUN \
  set -x \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y --no-install-recommends \
  locales \
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
  # Installing s3fs to map s3 bucket locally as an FS -> (https://github.com/s3fs-fuse/s3fs-fuse)
	s3fs \
	htop \
	gtop 

#	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
#	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture | awk -F- '{ print $NF }').asc" \
#	&& export GNUPGHOME="$(mktemp -d)" \
#	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
#	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
#	&& rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc \
#	&& chmod +x /usr/local/bin/gosu \
#	&& gosu nobody true

## Start: ffmpeg vulnerability fixing: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-17542
# Version affected: <= 4.1
# Version Fix: >= 4.2.0
# Fix: https://www.deb-multimedia.org/
# Resolve resource: https://security.gentoo.org/glsa/202003-65
# Debian version list: http://ftp.debian.org/debian/pool/main/f/ffmpeg/ or https://tracker.debian.org/pkg/ffmpeg
## END

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
