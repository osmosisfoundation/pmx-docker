#!/bin/bash

# TODO request/expect password as argument
docker build -f 73.Dockerfile --tag nonmem --build-arg NONMEM_ZIP_PASS_73=ADDYOURPASS .
