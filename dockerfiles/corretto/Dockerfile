#vim:set ft=dockerfile:

ARG BUILD_DIST_VERSION

# hadolint ignore=DL1000,DL3003,SC1035
FROM amazoncorretto:${BUILD_DIST_VERSION:-11}-alpine-jdk

# Declaring expected external variable
ARG BUILD_VERSION
ARG RELEASE_VERSION
ARG BUILD_DATE
ARG BUILD_HASH

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

#
## APK, basic command helper: https://www.cyberciti.biz/faq/10-alpine-linux-apk-command-examples/
#
## testing online: https://hadolint.github.io/hadolint/
## hadolint ignore=SC2155,DL3008,DL3015
RUN \
  apk update \
  && apk upgrade \
  && apk add --update --no-cache --virtual .tmp-build-deps \
    jq \
    rsync \
    ghostscript \
    ranger \
    py3-jinja2 \
    tzdata \
    less \
    libreoffice libreoffice-writer libreoffice-calc libreoffice-impress \
    libwpd-tools \
    # required by perl-Image-ExifTool to extract binary metadata from open office document
    perl-archive-zip \
    poppler-utils poppler-data poppler-qt5-dev \
    tar \
#    ufraw \
    wget \
    which \
    ca-certificates \
    net-tools \
    gzip \
    unzip \
    zip \
    perl \
    pwgen \
    x264 \
    htop \
    atop \
    ffmpeg ffmpegthumbnailer \
    imagemagick \
    bash \
    zsh \
    alpine-sdk \
    exiftool perl-image-exiftool perl-image-info \
#    gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev \
#    libressl-dev libffi-dev \
  && rm -rfv .tmp-build-deps \
  && rm -rf /var/cache/apk/*

##
# Specific install for ccextractor for alpine
##
RUN \
  apk add \
    cargo \
    bash  \
    build-base  \
    tesseract-ocr-dev \
    tesseract-ocr  \
    giflib \
    libwebp \
    leptonica \
    autoconf \
    automake \
    libtool

##
# Credit: https://hub.docker.com/r/gizmotronic/ccextractor/dockerfile
##
#RUN git clone https://github.com/CCExtractor/ccextractor \
# && ( \
#        cd ccextractor/linux/ \
#        && ./autogen.sh \
#        && ./configure \
#        && perl -i -pe 's/O3 /O3 -static /' Makefile \
#        && perl -i -pe 's/(strchr|strstr)\(/$1((char *)/'  ../src/gpacmp4/url.c  ../src/gpacmp4/error.c \
#        && set +e \
#        && make ENABLE_OCR=yes \
#        && set -e \
#        && gcc -Wno-write-strings -D_FILE_OFFSET_BITS=64 -DVERSION_FILE_PRESENT -O3 -std=gnu99 -s -DGPAC_CONFIG_LINUX -DENABLE_OCR -DPNG_NO_CONFIG_H -I/usr/local/include/tesseract -I/usr/local/include/leptonica $(find ../src -name '*.o') -o ccextractor \
#            --static -lm \
#            /usr/local/lib/libtesseract.a \
#            /usr/local/lib/liblept.a \
#            /usr/local/lib/libgif.a \
#            /usr/local/lib/libwebp.a \
#            /usr/lib/libjpeg.a \
#            /usr/lib/libtiff.a \
#            /usr/lib/libgomp.a \
#            -lstdc++ \
#    )
RUN \
  git clone https://github.com/CCExtractor/ccextractor \
  && ( \
      cd ccextractor/linux/ \
      && ./autogen.sh \
      && ./configure --without-rust \
      && make install \
    ) \
  && rm -rfv ccextractor

# Remove setuid/setgid binaries from images for security
RUN find / -perm 6000 -type f -exec chmod a-s {} \; || true

# Add a nuxeo user with a fixed UID
# We chose an arbitrary UID that doesn't conflict with possibly existing users
ENV NUXEO_USER nuxeo
ENV GROUP_NAME nuxeo

## Generic nuxeo user ID
ENV NUXEO_UID 900

RUN addgroup -g $NUXEO_UID $GROUP_NAME \
  && adduser \
    --disabled-password \
    -s /bin/bash \
    --uid $NUXEO_UID \
    --ingroup $GROUP_NAME $NUXEO_USER \
    -h /home/$NUXEO_USER

# enabling utf-8 by default
ENV LANG en_US.utf8

WORKDIR /

# Run as a non root user with a fixed UID
USER $NUXEO_UID

# vim:set et ts=2 sw=2:
