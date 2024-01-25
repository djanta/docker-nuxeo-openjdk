# vim:set ft=dockerfile:

FROM centos:7

# Declaring expected external variable
ARG BUILD_VERSION
ARG RELEASE_VERSION
ARG BUILD_DATE
ARG BUILD_HASH
ARG BUILD_CCEXTRACTOR_VERSION

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

# Configure Zulu Repository
RUN \
  rpm --import http://repos.azulsystems.com/RPM-GPG-KEY-azulsystems \
  && rpm --install http://cdn.azul.com/zulu/bin/zulu-repo-1.0.0-1.noarch.rpm

RUN yum -y update \
  && yum -y --setopt=skip_missing_names_on_install=False install \
    epel-release \
    zulu11-jdk \
  && yum -y --setopt=skip_missing_names_on_install=False install \
    ghostscript \
    ImageMagick-6.9.10.68-3.el7 \
    less \
    libreoffice-headless libreoffice-writer libreoffice-calc libreoffice-impress \
    libwpd-tools \
    # required by perl-Image-ExifTool to extract binary metadata from open office document
    perl-Archive-Zip \
    perl-Image-ExifTool \
    poppler-utils \
    tar \
    ufraw \
    wget \
    which \
    tzdata \
    yum-utils \
    ca-certificates \
    net-tools \
  	gzip \
  	unzip \
  	zip \
  	gnupg2 \
    perl \
    pwgen \
    htop \
  && yum -y localinstall --n\ogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm \
  && yum -y install ffmpeg \
  && yum clean all

RUN \
  yum -y --setopt=skip_missing_names_on_install=False install \
    autoconf \
    automake \
    libtool \
    make \
    git

RUN \
  git clone https://github.com/CCExtractor/ccextractor \
  && (cd ccextractor/ && git checkout -b feature/${BUILD_CCEXTRACTOR_VERSION:-v0.90} ${BUILD_CCEXTRACTOR_VERSION:-v0.90}) \
  && ( \
      cd ccextractor/linux/ \
      && ./autogen.sh \
      && ./configure --without-rust \
      && make install \
    ) \
  && rm -rfv ccextractor \
  && yum -y remove git \
  && yum clean all

# Remove setuid/setgid binaries from images for security
RUN find / -perm 6000 -type f -exec chmod a-s {} \; || true

# Add a nuxeo user with a fixed UID
# We chose an arbitrary UID that doesn't conflict with possibly existing users
ENV NUXEO_USER nuxeo

# Nuxeo given UID
ENV NUXEO_UID 900

RUN \
  useradd -m -d /home/$NUXEO_USER -u $NUXEO_UID -s /bin/bash $NUXEO_USER

WORKDIR /

# Run as a non root user with a fixed UID
USER $NUXEO_UID

# vim:set et ts=2 sw=2:
