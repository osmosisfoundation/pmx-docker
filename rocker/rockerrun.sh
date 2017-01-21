#!/bin/bash

echo NOTE: this will run in background, so you can then go run nonmem/psn stuff
echo Your data is in /data on RStudio server, so you\'ll need to change working dir in web UI
echo http://localhost:8787 RStudio on your local machine

docker rm -f rocker
docker run --rm --name rocker \
    -v $(pwd)/../data:/home/rstudio \
    -v $(pwd)/../license:/opt/nm730/license \
    -e ROOT=TRUE \
    -p 8787:8787 \
    rocker
