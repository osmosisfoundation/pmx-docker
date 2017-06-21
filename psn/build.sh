#!/bin/bash

NUM_THREADS=4
NONMEM_LICENSE_STRING=""
USAGE=$(printf "Usage: %s: -l license_string [-h threads]" $0)

while getopts ?l:h: name; do
    case $name in
        l) NONMEM_LICENSE_STRING=$OPTARG;;
        h) NUM_THREADS=$OPTARG;;
        ?)
	  echo -e $USAGE
          exit 0;;
    esac
done

docker build \
       --tag osmosisfoundation/psn:4.7.0 --tag osmosisfoundation/psn \
       --build-arg NONMEM_LICENSE_STRING=${NONMEM_LICENSE_STRING} \
       --build-arg NUM_THREADS=${NUM_THREADS} .
