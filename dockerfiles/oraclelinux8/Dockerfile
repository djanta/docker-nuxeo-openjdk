# vim:set ft=dockerfile:

ARG BUILD_JDK_VERSION
ARG BUILD_JDK_VARIANT

# hadolint ignore=DL1000,DL3003,SC1035
FROM openjdk:${BUILD_JDK_VERSION:-8}-${BUILD_JDK_VARIANT:-jdk}-oraclelinux8

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

ENV DEBIAN_FRONTEND=noninteractive
ENV JDK_VERSION=${BUILD_JDK_VERSION:-8}
ENV JDK_NAME=openjdk-${JDK_VERSION}-${BUILD_JDK_VARIANT:-jdk}

#SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# testing online: https://hadolint.github.io/hadolint/
# hadolint ignore=SC2155,DL3008,DL3015
# Add needed convert tools
RUN \
  set -x \
  && yum -y upgrade \
  && yum -y install \
  wget \
  perl \
  ImageMagick \
  ffmpeg \
  ffmpeg2theora \
  ufraw \
  ccextractor \
  poppler-utils \
  libreoffice \
  libwpd-tools \
  perl-Image-ExifTool \
  ghostscript \
  gzip \
  unzip \
  zip \
  gnupg2 \
  dirmngr \
  x264 \
  handbrake \
  inotify-tools \
  net-tools \
  pwgen \
  htop

RUN \
  set -x \
  && yum clean all

# enabling utf-8 by default
ENV LANG en_US.utf8

WORKDIR /

# vim:set et ts=2 sw=2:
