#!/bin/bash

# TODO request/expect password as argument
docker build --tag nonmem --build-arg NONMEMZIPPASS=gz952BqZX5 .
