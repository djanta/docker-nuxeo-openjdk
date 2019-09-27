FROM openjdk:8-jdk

MAINTAINER DJANTA, LLC <team.docker@djanta.io>

LABEL description="OpenJDK and Nuxeo preset tools build together and share across all over any Nuxeo specific distribution"
LABEL version="8-jdk"

ARG DEBIAN_FRONTEND

ENV DEBIAN_FRONTEND noninteractive

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.10

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
	&& apt-get update -y && apt-get install -y --no-install-recommends apt-utils apt-transport-https \
##	lsb-release \
##	software-properties-common \
	ca-certificates wget \
	# Installing inotify-tools and gzip
	inotify-tools gzip \
	# install gpg tools
	gnupg2 dirmngr \

  # Install nettool for 'netstat' purposes
  net-tools \

	# Install all nuxeo required tools
	perl imagemagick pwgen ffmpeg2theora ffmpeg ufraw x264 \
	libreoffice ghostscript exiftool poppler-utils libwpd-tools \
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

## make the "en_US.UTF-8" locale so postgres will be utf-8 enabled by default
ENV LANG en_US.utf8

WORKDIR /

# vim:set et ts=2 sw=2: