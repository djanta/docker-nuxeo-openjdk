# vim:set ft=dockerfile:

ARG BUILD_DIST_VERSION

FROM opensuse/leap:${BUILD_DIST_VERSION:-15}

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

ENV JDK_VERSION=${BUILD_JDK_VERSION:-1.9.0}
ENV JDK_NAME=openjdk-${JDK_VERSION}-${BUILD_JDK_VARIANT:-openjdk}

# Add repositories need it for ffmpeg2theora and ffmpeg
ARG NUX_DEXTOP_RPM_URL=http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm
ARG NUX_GPG_KEY_URL=http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro

# install java
#RUN yum install -y \
#  java-1.8.0-openjdk \
#  java-1.8.0-openjdk-devel \
#  wget

RUN yum -y install epel-release \
  && rpm --import ${NUX_GPG_KEY_URL} \
  && rpm -Uvh ${NUX_DEXTOP_RPM_URL}

# Add needed convert tools
RUN \
  set -x \
  && yum -y upgrade \
  && yum -y install \
  java-${JDK_VERSION}-${JDK_NAME} \
  java-${JDK_VERSION}-${JDK_NAME}-devel \
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
  pwgen

RUN \
  set -x \
  && yum clean all

WORKDIR /

# vim:set et ts=2 sw=2:
