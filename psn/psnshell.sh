#!/bin/bash

# give me a bash prompt in container data directory to run psn commands

docker run --rm --user=$(id -u):$(id -g) -v $(pwd)/../license:/opt/nm/license -v $(pwd)/../data:/data -it --entrypoint bash osmosisfoundation/psn


