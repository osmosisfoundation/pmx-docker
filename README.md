# pmx-docker
A docker for pharmacometrics workflows that work on local and cloud solutions

The `Fiona-Cluster-Documentation.md` file provides the basic cluster that was developed internally at CTM, University of Maryland by Vijay and Michael. The `howtoinstalls` folder provides all notes developed during my learning process of how to install various software and the networking area which Michael contributed a lot to.  There is definitely room for improvement.

The docker files in the `docker` folder in this repo are modification of [Pharmacometrics-Docker project](https://github.com/billdenney/Pharmacometrics-Docker) created by Bill Denny of HumanPredictions. Modifications have been made to try this out on my MBP, but I could only end up using the base image for NONMEM 7.3.0. However, this setup works on a single computer and is not designed to work as a cluster. The `pmx-docker` project being developed here intends to extend this functionality into many dimensions including cluster computing, easy deployment on cloud based solutions such as AWS, Microsoft Azure, Digital Ocean etc.

The main goals of this project are:

1. Improve the setup of the current docker images for pharmacometrics
2. Add new software in the containers, such as Phoenix, Monolix, SimCyp, GastroPlus, PdXPop etc.
3. Provide two deployment solutions:
  * as local installs on Windows/Mac/Linux Servers
  * as cloud based solutions
4. In both instances above, I propose the development of an easy to use web interface that will allow users to select software required, computing power required, in the case of cloud solutions an easy way to setup systems etc.
5. Add provisions for data volumes

### Initial steps

Incremental deliverables for this project:

1. Replicate the current system using the docker files provided on one computer on a Linux OS.
2. Improve the automation and efficiency of this setup
3. Replace the `Pmx_rocker_3.3.0_1.0.Dockerfile` with the highly stable and versatile [rocker](https://hub.docker.com/r/rocker/rstudio/) from rstudio.
4. Add provisions for data volumes and secure transfer.
5. Target local deploy on one machine with the setup above
6. Scale this up to a cluster based system both local and cloud

### Possible Image combinations

Allow user to choose mix and match of software required

1. NONMEM + PsN + R + Rstudio server (single local machine, windows, macos, linux)
2. NONMEM + PsN + R + Rstudio server (deployed as a cluster with a single head node and multiple compute nodes. Head node serves as a data volume. On a local server or an AWS kind of system)
3. R + Rstudio server installed with specialized packages for pharmacometric simulations (single local machine, windows, macos, linux)
4. R + Rstudio server installed with specialized packages for pharmacometric simulations (deployed as a cluster with a single head node and multiple compute nodes. Head node serves as a data volume. On a local server or an AWS kind of system)

## Next Steps
Once these above systems are succesfully setup, we will take this forward to include other pharmacometric software mentioned earlier.
