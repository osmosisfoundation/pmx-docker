#!/bin/bash

# TODO request/expect password as argument

docker build --tag piranajs --build-arg PIRANAJSSOURCE=piranajs_current_20160601.zip .
