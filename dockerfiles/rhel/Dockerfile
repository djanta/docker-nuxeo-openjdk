# vim:set ft=dockerfile:

ARG BUILD_JDK_VERSION
ARG BUILD_JDK_VARIANT

FROM registry.access.redhat.com/rhel7

# Declaring expected external variable
ARG BUILD_VERSION
ARG RELEASE_VERSION
ARG BUILD_DATE
ARG BUILD_HASH
ARG BUILD_JDK_VERSION
ARG BUILD_JDK_VARIANT

LABEL description="DJANTA.IO Nuxeo SDK Base image share across all over any specific nuxeo version distribution"
LABEL version="$BUILD_VERSION"
LABEL maintainer="DJANTA, LLC <cloud.packager@djanta.io>"
LABEL author="Koffi Stanislas ASSOUTOVI"
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

LABEL io.k8s.description="Starts a Nuxeo Platform server."
LABEL io.k8s.display-name="Nuxeo"
LABEL io.openshift.tags="nuxeo nuxeo-sdk djanta-nuxeo-sdk"
LABEL io.openshift.min-memory="2Gi"
LABEL io.openshift.min-cpu="2"
LABEL io.openshift.min-cpu="2"
LABEL url="https://djanta.io/"
LABEL summary="DJANTA.IO Nuxeo SDK Base image share across all over any specific nuxeo version distribution"
LABEL release="$RELEASE_VERSION"

# install java
#RUN yum-config-manager --disable rhel-7-server-htb-rpms \
#  && yum install -y \
#  wget unzip

#Add repositories need it for ffmpeg2theora and ffmpeg
# ARG EPEL_RPM_URL=https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# ARG NUX_GPG_KEY_URL=http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
# ARG NUX_DEXTOP_RPM_URL=http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm
# RUN wget ${EPEL_RPM_URL} \
#     && rpm -Uvh epel-release-latest-7*.rpm \
#     && rpm --import ${NUX_GPG_KEY_URL} \
#     && rpm -Uvh ${NUX_DEXTOP_RPM_URL}

## must find another way to install it, need it for ffmpeg
# ARG NUX_DEXTOP_FRIBIDI_RPM_URL=ftp://ftp.pbone.net/mirror/li.nux.ro/download/nux/dextop/retired/libfribidi-0.19.2-3.el7.nux.x86_64.rpm
# RUN rpm -Uvh ${NUX_DEXTOP_FRIBIDI_RPM_URL}

# enable repo for libreoffice
RUN yum-config-manager --enable rhel-7-server-optional-rpms

# Add needed convert tools
RUN yum -y upgrade \
  && yum -y install \
  perl \
  ImageMagick \
#   ffmpeg \
#   ffmpeg2theora \
  ufraw \
  poppler-utils \
  libreoffice-core  \
  libwpd-tools \
  perl-Image-ExifTool \
  ghostscript \
  && yum clean all

ADD licenses /licenses
ADD help.1 /help.1

RUN yum list installed

# enabling utf-8 by default
ENV LANG en_US.utf8

WORKDIR /

# vim:set et ts=2 sw=2:
