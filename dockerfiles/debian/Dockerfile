FROM debian:10.4-slim

ARG BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
ARG BUILD_VERSION="$(date -u +'%y.%m')"
ARG RELEASE_VERSION="$(date -u +'%y.%m')"
ARG LAST_COMMIT="$(git rev-parse HEAD)"
ARG BUILD_HASH="$LAST_COMMIT"

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

#=====================
# Updates for debconf
# Prevent message 'debconf: unable to initialize frontend: Dialog'
# Prevent message 'debconf: delaying package configuration, since apt-utils is not installed'
#=====================
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Activate the debug option
RUN set -x \
##  && apt-cache policy lsb-release \
#	# Registering (add-apt-repository)
##	&& echo "deb https://apt.dockerproject.org/repo $(lsb_release -is)-$(lsb_release -cs) main" >> /etc/apt/source.list \
  # && apt install software-properties-common -y
	&& apt-get update -y \
	&& apt-get install -y --no-install-recommends \
	apt-utils \
	apt-transport-https \
##	lsb-release \
##	software-properties-common \
	ca-certificates wget \
# Installing inotify-tools that should be used in the sub-adjacent image to synchronize the developer build 
	inotify-tools \
# Install nettool for 'netstat' purposes
  	net-tools \
	gzip \
	gnupg2 \
	dirmngr \
# Install all nuxeo required tools
	perl \
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
#	# Just for a debuging purposes ...
##  && lsb_release -a && lsb_release -cs && lsb_release -is \
#  # Registering yq (repository)
##  && add-apt-repository ppa:rmescandon/yq && apt-get update -y \
#  # Install Yaml Parser & Json Parser
##  && apt-get install -y yq jq \
	# Clenaing up ...
	&& rm -rf /var/lib/apt/lists/* \
	#&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true \
# Purge & remove unnecessary dependencies ....
	&& apt-get purge -y --auto-remove ca-certificates wget

# enabling utf-8 by default
ENV LANG en_US.utf8

WORKDIR /

# vim:set et ts=2 sw=2:
