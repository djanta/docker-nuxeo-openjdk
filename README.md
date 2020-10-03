# Nuxeo Docker Essentials

[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/djanta/docker-nuxeo-sdk)](https://github.com/djanta/docker-nuxeo-sdk)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/djanta/docker-nuxeo-sdk?color=brightgreen&include_prereleases)](https://github.com/djanta/docker-nuxeo-sdk)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/djanta/nuxeo-sdk)](https://github.com/djanta/docker-nuxeo-sdk)

[![stars badge](https://img.shields.io/docker/stars/djanta/nuxeo-sdk.svg)](https://github.com/djanta/docker-nuxeo-sdk)
[![pull badge](https://img.shields.io/docker/pulls/djanta/nuxeo-sdk.svg)](https://github.com/djanta/docker-nuxeo-sdk)
[![Docker image](https://images.microbadger.com/badges/image/djanta/nuxeo-sdk.svg)](https://microbadger.com/images/djanta/docker-nuxeo-sdk)

> 1.0.0

## Getting Started

These instructions will cover usage information and for the docker container 

## Introduction
The main purposes of this project is to provide a high level container which'll come up with the minimum and essentials tools required by `nuxeo` 
framework to be functionning. Please do keep in mind that, this container will not bring up the `nuxeo` server instance. To have a ready to do `nuxeo`
container, [used the following image instead](https://github.com/djanta/docker-nuxeo-server).
To build your own image from this, follow the steps above and with lucky you will have a working container ;)

## Main tools

First of all, base on many feedback inquiries we've got, I can stress enough that, this `SDK` image come up with diffrent `*nix` based distribution.
As for today, we've not published any `windows` based distribution. In our team and for most of our clients, we mostly use this `openjdk` version, but you are free to
choose your favorite distribution (as long as your are able to manage distribution specific problems without help from
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

| Platform                     | Versions                                         | Architectures |
| ---------------------------- | ------------------------------------------------ | ------------- |
| AIX                          | 6.1, 7.1, 7.2                                    | ppc64         |
| CentOS                       | 5, 6, 7                                          | i386, x86_64  |
| Debian                       | 7, 8, 9                                          | i386, x86_64  |
| FreeBSD                      | 9, 10, 11                                        | i386, amd64   |
| Mac OS X                     | 10.9, 10.10, 10.11, 10.12, 10.13, 10.14          | x86_64        |
| Oracle Enterprise Linux      | 5, 6, 7                                          | i386, x86_64  |
| Red Hat Enterprise Linux     | 5, 6, 7                                          | i386, x86_64  |
| Solaris                      | 10, 11                                           | sparc, x86    |
| Ubuntu Linux                 |                                                  | x86, x86_64   |
| SUSE Linux Enterprise Server | 11, 12                                           | x86_64        |
| Scientific Linux             | 5.x, 6.x and 7.x                                 | i386, x86_64  |
| Fedora                       |                                                  | x86_64        |
| OpenSUSE                     | 13, 42                                           | x86_64        |
| OmniOS                       |                                                  | x86_64        |
| Gentoo Linux                 |                                                  | x86_64        |
| Arch Linux                   |                                                  | x86_64        |
| HP-UX                        | 11.31                                            | ia64          |

\**For Windows, PowerShell 5.0 or above is required.*

In addition, runtime support is provided for:

| Platform | Versions | Arch   |
| -------- | -------- | ------ |
| Debian   | 8, 9     | x86_64 |
| RHEL     | 6, 7     | x86_64 |
| Ubuntu   | 12.04+   | x86_64 |

## Supported JDK

| | Debian   |      Centos     |  rhel |
|:----------:|:----------:|:-------------:|:---------:|
|8| √ |  √ | √ |
|11| √ |  √ | √ |
|14| √ |  √ | √ |
|15| √ |  √ | √ |
|16| √ |  √ | √ |


## Where from?
As we're making all our containers to be largely available and easier to use, we'll be distribuating this images through the following registries:

|                           |                           |                       |
| ------------------------- | ------------------------- | --------------------- |
| **Docker Registry**       | hub.docker.io             | √                     |
| **Github Registry**       | docker.pkg.github.com     | √                     |
| **Openshift Registry**    |                           | X                     |
| **Amazon Registry**       |                           | X                     |

## Installed Software

| | Debian   |      Centos     |  rhel |
|----------:|:----------:|:-------------:|:---------:|
|ImageMagick| √ |  √ | √ |
|ffmpeg| √ |  √ | √ |
|ffmpeg2theora| √ |  √ | √ |
|ufraw| √ |  √ | √ |
|ccextractor| √ |X| √ |
|libreoffice| √ |  √ | √ |
|libwpd-tools| √ |  √ | √ |
|perl-Image-ExifTool| √ |  √ | √ |
|ghostscript| √ |  √ | √ |
|pwgen| √ |  √ | √ |

### Usage
This container can be used through these following steps:

```dockerfile
FROM djanta/nuxeo-sdk-${platform}:${jdkversion}-${jdkvariant}
```

#### Pull
As requested with the request this bundle can be run within the command bellow:
```sh
$ docker pull djanta/nuxeo-sdk-${platform}:${jdkversion}-${jdkvariant}

# Example for the heaviest version 
$ docker pull djanta/nuxeo-sdk-debian:8-jdk

# Example for the light version 
$ docker pull djanta/nuxeo-sdk-debian:8-jdk-slim
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
