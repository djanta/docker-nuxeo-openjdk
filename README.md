# Nuxeo docker essentials

![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/djanta/docker-nuxeo-sdk)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/djanta/docker-nuxeo-sdk?color=brightgreen&include_prereleases)
[![pull badge](https://img.shields.io/docker/pulls/djanta/nuxeo-sdk.svg)](https://github.com/djanta/docker-nuxeo-sdk)
[![stars badge](https://img.shields.io/docker/stars/djanta/nuxeo-sdk.svg)](https://github.com/djanta/docker-nuxeo-sdk)
![GitHub](https://img.shields.io/github/license/djanta/docker-nuxeo-sdk?color=brightgreen)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/djanta/nuxeo-sdk)

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

## Built With

| | OpenJDK (Debian)   |      Centos     |  rhel |
|:----------:|:----------:|:-------------:|:---------:|
|8| [x] |  [x] | [x] |
|11| [x] |  [x] | [x] |
|14| [x] |  [x] | [x] |
|15| [x] |  [x] | [x] |
|16| [x] |  [x] | [x] |


### Usage
This container can be used through these following steps:

#### Build from
Before use `transform.jar` you can run de following command to display all available options:

```dockerfile
FROM djanta/docker-nuxeo-sdk:${version}-${variant}
```

#### Pull
As requested with the request this bundle can be run within the command bellow:
```sh
$ docker pull djanta/docker-nuxeo-sdk:{version}-{variant}
``` 

## Find Us

* [GitHub](https://github.com/djanta/docker-nuxeo-sdk)

## Contributing

Please read [CONTRIBUTING.md](https://github.com/djanta/docker-nuxeo-sdk/blob/master/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

* **Stanislas Koffi ASSOUTOVI** - *Initial work* - [docker-nuxeo-sdk](https://github.com/stanislaska)

See also the list of [contributors](https://github.com/djanta/docker-nuxeo-sdk/contributors) who participated in this project.

## License

Licensed under the MIT License - see the [LICENSE.md](https://github.com/djanta/docker-nuxeo-sdk/blob/master/LICENSE) file for details.
