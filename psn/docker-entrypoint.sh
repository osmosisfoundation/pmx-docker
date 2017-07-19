#!/bin/bash

# this script is copied into psn image and run on each container start

# if command starts with an option, prepend psn
if [ "${1:0:1}" = '-' ]; then
	set -- psn "$@"
fi

printf "[default_options]\nthreads=$NUM_THREADS" > /root/psn.conf

exec "$@"
