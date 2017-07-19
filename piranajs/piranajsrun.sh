#!/bin/bash

docker run --rm \
    -v $(pwd)/../license:/opt/nm730/license \
    -v $(pwd)/../license:/opt/pirana/license \
    -v $(pwd)/../data:/data \
    -p 8787:8787 \
    -p 8000:8000 \
    -it \
    --entrypoint bash \
    osmosisfoundation/piranajs:latest


