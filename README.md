# Concourse-Local
Automate the installation and basic setup of concourse-ci and the fly
executable under macOS, including unsigned app support for Big Sur.

## Copyright and Licensing

### Copyright Notice

The copyright for the software, documentation, and associated files are
held by the author.

    Copyright © 2020, 2021 Todd A. Jacobs
    All rights reserved.

The AUTHORS file is also included in the source tree.

### Software License

![GPLv3 Logo](http://www.gnu.org/graphics/gplv3-88x31.png)

The software is licensed under the
[GPLv3](http://www.gnu.org/copyleft/gpl.html). The software's LICENSE
file is included in the source tree.

### README License

![Creative Commons BY-NC-SA 4.0
Logo](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)

This README is licensed under the [Creative Commons
Attribution-NonCommercial-ShareAlike 4.0 International
License](http://creativecommons.org/licenses/by-nc-sa/4.0/). The
README's license file is included in the source tree.

## Purpose

The installer simplifies installation of
[Concourse-CI](https://concourse-ci.org/) and its *fly* CLI under macOS,
with support for the CLI's unsigned app, which (IIRC) the Pivotal
maintainers say they have no intention of addressing. 😢

## Prerequisites
These are required before running the installation script.

1. [Homebrew](https://brew.sh/)
1. [Bash](https://www.gnu.org/software/bash/)

## Dependencies
These dependencies are installed via the installation script, provided
the prerequisites have been met.

1. [Docker Desktop](https://www.docker.com/products/docker-desktop)
1. [VirtualBox](https://www.virtualbox.org/) (NB: This may be optional,
   but Docker Desktop seems happier when it's installed.)
1. [GNU Wget](https://www.gnu.org/software/wget/)

## Installation and Setup

    git clone https://github.com/todd-a-jacobs/concourse-local.git
    cd concourse-local
    ./install.sh

## Usage

    open http://localhost:8080

----

[Project Home Page](https://github.com/todd-a-jacobs/concourse-local)
