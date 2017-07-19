#!/bin/bash

# this script is copied into rocker image and run on each container start

printf "[default_options]\nthreads=$NUM_THREADS" > /home/rstudio/psn.conf

exec "$@"
