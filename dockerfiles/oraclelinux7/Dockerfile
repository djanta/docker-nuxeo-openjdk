# vim:set ft=dockerfile:

ARG BUILD_JDK_VERSION
ARG BUILD_JDK_VARIANT

# hadolint ignore=DL1000,DL3003,SC1035
FROM openjdk:${BUILD_JDK_VERSION:-10}-${BUILD_JDK_VARIANT:-jdk}-oraclelinux7

# Declaring expected external variable
ARG BUILD_VERSION
ARG RELEASE_VERSION
ARG BUILD_DATE
ARG BUILD_HASH
ARG BUILD_JDK_VERSION
ARG BUILD_JDK_VARIANT

LABEL description="DJANTA.IO Nuxeo SDK Base image share across all over any specific nuxeo version distribution"
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
LABEL org.label-schema.description="DJANTA.IO Nuxeo SDK Base image share across all over any specific nuxeo version distribution"
LABEL org.label-schema.vcs-url="https://github.com/djanta/docker-nuxeo-sdk"
LABEL org.label-schema.vcs-ref=$BUILD_HASH

#ENV DEBIAN_FRONTEND=noninteractive
ENV IMAGE_MAGICK_MAX_TREAD=1
#ENV TZ 'America/Chicago'
ENV TZ 'GMT+0'

# testing online: https://hadolint.github.io/hadolint/
# hadolint ignore=SC2155,DL3008,DL3015
# Add needed convert tools
RUN \
  set -x \
  && yum -y upgrade \
  && yum update -y \
  && yum install -y \
  which \
  locales \
  tzdata \
  yum-utils \
	transport-https \
	ca-certificates \
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
	jq \
	rsync \
	htop

# Configure timezone
RUN \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone

RUN \
  set -x \
  && yum clean all -y

# Check if hava has been install ...
RUN \
  which java \
  && java -version \
  && echo "JAVA_HOME --> $JAVA_HOME"

# enabling utf-8 by default
ENV LANG en_US.utf8

WORKDIR /

# vim:set et ts=2 sw=2:
