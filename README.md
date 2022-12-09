# Nuxeo SDK Essentials

[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/djanta/docker-nuxeo-sdk)](https://github.com/djanta/docker-nuxeo-sdk)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/djanta/docker-nuxeo-sdk?color=brightgreen&include_prereleases)](https://github.com/djanta/docker-nuxeo-sdk)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/djanta/nuxeo-sdk)](https://github.com/djanta/docker-nuxeo-sdk)
[![stars badge](https://img.shields.io/docker/stars/djanta/nuxeo-sdk.svg)](https://github.com/djanta/docker-nuxeo-sdk)
[![pull badge](https://img.shields.io/docker/pulls/djanta/nuxeo-sdk.svg)](https://github.com/djanta/docker-nuxeo-sdk)
[![Docker image](https://images.microbadger.com/badges/image/djanta/nuxeo-sdk.svg)](https://microbadger.com/images/djanta/docker-nuxeo-sdk)

> 2021.12

## Getting Started

These instructions will cover usage information and for the docker container 

## Introduction
The main purposes of this project are to provide a high-level container that comes up with the minimum and essentials tools required by `Nuxeo`
the framework to be functioning. Please do keep in mind that, this container will not bring up the `Nuxeo` server instance. To have a ready to do `Nuxeo`
container, [used the following image instead](https://github.com/djanta/docker-nuxeo-server).
To build your own image from this, follow the steps above, and with luck, you'll have a working container ;)

## Caution

This image aim to provide the `SDK` level in support for `Nuxeo` base server distribtion. Therefore, all thrid party sofware provided within
this image have been tested and ensure that all required builtin with `nuxeo` base are functionning properly. 

Yo can as needed build from this image e.g: `FROM djanta/nuxeo-sdk:${VERSION_TAG}` and just install your target nuxeo server distribution.

## Main tools

First of all, base on many feedback inquiries we've got, I can stress enough that, this `SDK` image comes up as of now with mainly `centos:7` and amazon `corretto:11-alpine-jdk`.
As for today, we've not yet published any `windows` based distribution.
In our team and for most of our clients, we mostly use this `JDK 11 azul` version, but you are free to
choose your favorite distribution (as long as you're able to manage distribution specific problems without help from
US).

### Prerequisities

In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

_*After, you need to set up following tools. Just go on official websites to see setup instructions.*_

### Package source

If you want to install some additional package, here's one important and easier way to find them [database](https://pkgs.org/download/)

## Supported platform

Remote Targets

| Platform | Versions | Architectures |
|----------|---------| ------------- |
| CentOS   | 7       | i386, x86_64  |
| Corretto   | 11        | i386, x86_64  |

## Supported JDK

| | Centos   | Corretto | Debian |      Fedora     |      Opensuse     |  rhel |  OracleLinux7 |
|:----------:|:----------:|:--------:|:------:|:-------------:|:-------------:|:---------:|:---------:|
|11| √ |    √     |   X    | X | X | X | X |

## Installed Software

| | Centos | Corretto | --  | --  |
|----------:|:------:|:--------:|:---:|:---:|
|ImageMagick|   √    |    √     |  √  |
|ffmpeg|   √    |    √     |  √  |
|ffmpeg2theora|   √    |    √     |  √  |
|ufraw|   √    |    √     |  √  |
|imagemagick|   √    |    √     |  √  |
|ccextractor|   √    |    √     |  X  |
|libreoffice|   √    |    √     |  √  |
|libwpd-tools|   √    |    √     |  √  |
|perl-Image-ExifTool|   √    |    √     |  √  |
|ghostscript|   √    |    √     |  √  |
|ca-certificates|   √    |    √     |  X  |
|yum-utils|   √    |    X     |  X  |
|pwgen|   √    |    √     |  √  |
|wget|   √    |    √     |  √  |
|curl|   √    |    √     |  √  |
|tzdata|   √    |    √     |  √  |
|gzip|   √    |    √     |  √  |
|unzip|   √    |    √     |  √  |
|zip|   √    |    √     |  √  |
|gnupg2|   √    |    √     |  √  |
|dirmngr|   √    |    √     |  √  |
|perl|   √    |    √     |  √  |
|py3-jinja2|   X    |    √     |  X  |
|jq|   √    |    √     |  √  |
|htop|   √    |    √     |  √  |
|ranger|   √    |    √     |  √  |

## Where from?
As we're making all our containers to be largely available and easier to use, we'll be distributing this images through the following registries:

|                           |                           |     |
| -------------------------:|:------------------------- |:---:|
| **Docker Registry**       | hub.docker.io             |  √  |
| **Github Registry**       | docker.pkg.github.com     |  X  |
| **Openshift Registry**    |                           |  X  |
| **Amazon Registry**       |                           |  X  |

### Versioning format

This package versioning format is based on a combinaison of current time of build and the `jdk` version as follow:

#### Date format

```sh
VERSION_SUFFIX=$(date -u +'%y.%m')
```

#### Version Tagging

```sh
VERSION_TAG="${VERSION_SUFFIX}-${DISTRIBUTION}"
```

### Usage
This container can be used through these following steps:

```dockerfile
FROM djanta/nuxeo-sdk:${VERSION_TAG}
```

#### Pull
As requested with the request this bundle can be run within the command bellow:
```sh
$ docker pull djanta/nuxeo-sdk:${VERSION_TAG}

# Example for the LTS 2021 build in December for `centos` 
$ docker pull djanta/nuxeo-sdk-debian:2021.12-contos
``` 

## BUILD ENV VARIABLE

#### LANG
**Type:** `String` <br/>
**Default value:** `en_US.utf8` <br/>

A litteral string value which export the container default **_lang_**.

#### DEBIAN_FRONTEND
**Type:** `String` <br/>
**Default value:** `noninteractive` <br/>

A litteral string value which export the container default **_lang_**.

#### TZ
**Type:** `String` <br/>
**Default value:** `GMT+0` <br/>

A litteral string value which export the container default **_timezone_**.
A list of known available timezone is provide within the distribution in the file `.tz`. The timezone can be modified at anytime
by invoking the following command: `echo "MY PREFERED TIMEZONE" > /etc/timezone`

## Distribution stats
|                           |                           |                       ||
| ------------------------- | ------------------------- | --------------------- |--------------------- |
| **Debian** (```docker pull djanta/nuxeo-sdk-debian```)| ![stars badge](https://img.shields.io/docker/stars/djanta/nuxeo-sdk-debian.svg)| ![pull badge](https://img.shields.io/docker/pulls/djanta/nuxeo-sdk-debian.svg)|[![Docker image](https://images.microbadger.com/badges/image/djanta/nuxeo-sdk-debian.svg)](https://microbadger.com/images/djanta/nuxeo-sdk-debian)
| **Centos** (```docker pull djanta/nuxeo-sdk-centos```)|||
| **Ubuntu** (```docker pull djanta/nuxeo-sdk-ubuntu```)||
| **Fedora** (```docker pull djanta/nuxeo-sdk-fedora```)|||

## Contributing

Please read [CONTRIBUTING.md](https://github.com/djanta/docker-nuxeo-sdk/blob/master/CONTRIBUTING.md) for details on 
our code of conduct, and the process for submitting pull requests to us.

## License

|                |                                                                  |
| -------------- | ---------------------------------------------------------------- |
| **Author:**    | [Stanislas Koffi ASSOUTOVI](https://github.com/stanislaska)      |
| **License:**   | The MIT License (MIT)                                            |

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://github.com/djanta/docker-nuxeo-sdk/blob/master/LICENSE

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
