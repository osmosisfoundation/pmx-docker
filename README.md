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
