#!/bin/bash

NONMEM_MAJOR_VERSION=7
NONMEM_MINOR_VERSION=4
NONMEM_PATCH_VERSION=1

USAGE=$(printf "Usage: %s: [-j major_version] [-n minor_version] [-t patch_version] zip_password\\\\n e.g. %s -j %s -n %s -t %s my_password\\\n or e.g. %s my_password" $0 $0 ${NONMEM_MAJOR_VERSION} ${NONMEM_MINOR_VERSION} ${NONMEM_PATCH_VERSION} $0)


while getopts ?j:n:t: name; do
  case $name in
  j) NONMEM_MAJOR_VERSION=$OPTARG;;
  n) NONMEM_MINOR_VERSION=$OPTARG;;
  t) NONMEM_PATCH_VERSION=$OPTARG;;
  ?)
     echo -e $USAGE
     exit 0;;
  esac
done
shift $(($OPTIND - 1))
PASSWORD=$1

if [[ -z $PASSWORD ]]; then
  echo "Error: zip password is required"
  echo -e $USAGE
  exit 1
fi

docker build -f NONMEM.Dockerfile \
  --tag osmosisfoundation/nonmem:${NONMEM_MAJOR_VERSION}.${NONMEM_MINOR_VERSION}.${NONMEM_PATCH_VERSION} \
  --tag osmosisfoundation/nonmem \
  --build-arg NONMEM_MAJOR_VERSION=${NONMEM_MAJOR_VERSION} \
  --build-arg NONMEM_MINOR_VERSION=${NONMEM_MINOR_VERSION} \
  --build-arg NONMEM_PATCH_VERSION=${NONMEM_PATCH_VERSION} \
  --build-arg NONMEM_ZIP_PASS=$PASSWORD .
