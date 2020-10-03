# vim:set ft=dockerfile:

ARG BUILD_DIST_VERSION

FROM centos:${BUILD_DIST_VERSION:-7}

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

ENV JDK_VERSION=11
#${BUILD_JDK_VERSION:-1.8.0}
ENV JDK_NAME=${BUILD_JDK_VARIANT:-jdk}

# Add repositories need it for ffmpeg2theora and ffmpeg
#ARG NUX_DEXTOP_RPM_URL=http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm
ARG NUX_DEXTOP_RPM_URL=http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
ARG NUX_GPG_KEY_URL=http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro

##
# https://centos.pkgs.org/
##
# Needed for dirmngr
ARG TRINITY_REPO_URL=http://mirror.ppa.trinitydesktop.org/trinity/rpm/el7/trinity-r14/RPMS/noarch/trinity-repo-14.0.8-1.el7.noarch.rpm
ARG DIRMNGR_URL=https://ftp.fau.de/trinity/trinity/rpm/el7/trinity-r14/RPMS/x86_64/dirmngr-1.1.1-5.el7.x86_64.rpm
#ARG HANDBRAKE_URL=https://li.nux.ro/download/nux/dextop/el7/x86_64/HandBrake-cli-0.9.9-5.el7.nux.x86_64.rpm

##
# Registering and installing all third part gpgkeys and repos.
##
RUN yum -y install epel-release \
  && rpm --import ${NUX_GPG_KEY_URL} \
  && rpm -Uvh ${NUX_DEXTOP_RPM_URL}

RUN \
  echo "Java: openjdk-${JDK_VERSION}-${JDK_NAME}" \
  echo "Devel: openjdk-${JDK_VERSION}-${JDK_NAME}-devel"

# Add needed convert tools
RUN \
  set -x \
  && yum -y upgrade \
  && yum -y install \
#  && yum -y remove jdk \
  java-${JDK_VERSION}-${JDK_NAME} \
  java-${JDK_VERSION}-${JDK_NAME}-devel \
#  openjdk-${JDK_VERSION}-${JDK_NAME} \
#  openjdk-${JDK_VERSION}-${JDK_NAME}-devel \
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
  unzip \
  zip \
  dirmngr \
  x264 \
  handbrake-cli \
  inotify-tools \
  net-tools \
  pwgen

# /dev/urandom is used as random source, which is prefectly safe. CREDIT http://www.2uo.de/myths-about-urandom/
RUN \
  echo "securerandom.source=file:/dev/urandom" >> /usr/lib/jvm/jre/lib/security/java.security

RUN \
  echo "JAVA: $JAVA_HOME"

RUN \
  set -x \
  && yum clean all

RUN \
  if [ -d /etc/alternatives ]; then \
    ls -als /etc/alternatives/; \
  fi

ENV JAVA_HOME /etc/alternatives/jre

WORKDIR /

# vim:set et ts=2 sw=2:
