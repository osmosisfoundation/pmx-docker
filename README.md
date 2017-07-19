# pmx-docker
A set of docker containers and scripts for pharmacometrics workflows that work on local and cloud solutions

This repository houses files for 4 different container builds based on your needs:

image            | description                               | size
---------------- | ----------------------------------------- | ------
[nonmem](https://hub.docker.com/r/osmosisfoundation/nonmem/)  |  NONMEM installed on Ubuntu  | [![](https://images.microbadger.com/badges/image/osmosisfoundation/nonmem.svg)](https://microbadger.com/images/osmosisfoundation/nonmem)
[psn](https://hub.docker.com/r/osmosisfoundation/psn/)  | Adds Perl-speaks-NONMEM to above | [![](https://images.microbadger.com/badges/image/osmosisfoundation/psn.svg)](https://microbadger.com/images/osmosisfoundation/psn)
[piranajs](https://hub.docker.com/r/osmosisfoundation/piranajs/builds/)  |  Adds PiranaJS to above | [![](https://images.microbadger.com/badges/image/osmosisfoundation/piranajs.svg)](https://microbadger.com/images/osmosisfoundation/piranajs)
[rocker](https://hub.docker.com/r/osmosisfoundation/osmosisfoundation/)  |  Rocker full rstudio (rocker/verse) with NONMEM and PSN  | [![](https://images.microbadger.com/badges/image/osmosisfoundation/rocker.svg)](https://microbadger.com/images/osmosisfoundation/rocker)


The Dockerfiles in various folders in this repo are modifications of [Pharmacometrics-Docker project](https://github.com/billdenney/Pharmacometrics-Docker) created by Bill Denny of HumanPredictions. 

The main goals of this project are:

1. Improve the setup of the current docker images for pharmacometrics
2. Add new software in the containers, such as Phoenix, Monolix, SimCyp, GastroPlus, PdXPop etc.
3. Provide two deployment solutions:
  * as local installs on Windows/Mac/Linux Servers
  * as cloud based solutions
4. In both instances above, develop an easy to use web interface that will allow users to select software required, computing power required, in the case of cloud solutions an easy way to setup systems etc.
5. Add provisions for data volumes

## How To Use

1. Clone this repo e.g. `git clone https://github.com/osmosisfoundation/pmx-docker.git`
2. If using nonmem, copy your license file to `./license`
    1. nonmem: `./license/nonmem.lic` 
    2. psn: (requires nonmem license above) 
    3. piranajs: `./license/piranajs.lic`
3. Place any working data you want to use with these tools in `./data` and it'll be shared (via bind mount) with app in its container
4. Install the latest Docker for your OS from [store.docker.com](https://store.docker.com). (your built-in package manager likely doesn't have latest, so always use install steps from [store.docker.com](https://store.docker.com))
    1. Windows 10 Pro/Enterprise: ["Docker for Windows"](https://store.docker.com/editions/community/docker-ce-desktop-windows)
    2. Windows 7/8/10 Home: ["Docker Toolbox"](https://www.docker.com/products/docker-toolbox)
    3. macOS Yosemite (10.10) or above: ["Docker for Mac"](https://store.docker.com/editions/community/docker-ce-desktop-mac)
    4. macOS 10.9 and older: ["Docker Toolbox"](https://www.docker.com/products/docker-toolbox)
    5. Linux: Find your distribution specific steps at [store.docker.com](https://store.docker.com/search?offering=community&operating_system=linux&platform=server&q=&type=edition)
5. These tools are meant to use `docker-compose` command line tool by default, which makes them much easier to use.
6. Verify `docker` and `docker-compose` work by trying `docker version` and `docker-compose version`.  Latest (July 2017) is 17.06 and 1.14
7. From the root of this project (pmx-docker) you can run nonmem:
    - `docker-compose run nonmem <nonmem options>`
    - assuming data files are in the `./data` directory, you might use `docker-compose run nonmem controlfile output.res`
8. You can run PsN the same way:
    - `docker-compose run psn <psn options>` 
9. To launch a rocker or piranajs server, use the `up` command:
    - `docker-compose up rocker` or `docker-compose up piranaja`
    - To run them in background add `-d` after the `up`
    - Default rocker install will be accessible at `http://localhost:8787`
    - Default piranajs install will be accessible at `http://localhost:8000`
    - If using Docker Toolbox, replace `localhost` with `192.168.99.100`

### Advanced usage

1. If you want to build your own images rather then use our prebuilt ones, you can use the alternate compose file like so: `docker-compose -f docker-compose-build.yml run nonmem <options>` and it will build the `Dockerfile` in the nonmem directory.
2. Would you like to override settings in `docker-compose.yml` without changing files in this repo (makes it easier to update with `git pull`), then create a copy as `docker-compose.override.yml` and delete everything except what you want to change (e.g. volume bind mount location), that file name is ignored by this git repo, and will automatically be used when running `docker-compose`. More information [at the Docker Docs](https://docs.docker.com/compose/extends/#multiple-compose-files).