# pmx-docker
A docker for pharmacometrics workflows that work on local and cloud solutions

The docker files in the `docker` folder in this repo are modification of [Pharmacometrics-Docker project](https://github.com/billdenney/Pharmacometrics-Docker) created by Bill Denny of HumanPredictions. 

The main goals of this project are:

1. Improve the setup of the current docker images for pharmacometrics
2. Add new software in the containers, such as Phoenix, Monolix, SimCyp, GastroPlus, PdXPop etc.
3. Provide two deployment solutions:
  * as local installs on Windows/Mac/Linux Servers
  * as cloud based solutions
4. In both instances above, develop an easy to use web interface that will allow users to select software required, computing power required, in the case of cloud solutions an easy way to setup systems etc.
5. Add provisions for data volumes
