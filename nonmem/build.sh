#!/bin/bash

NONMEM_MAJOR_VERSION=7
NONMEM_MINOR_VERSION=4
NONMEM_PATCH_VERSION=1
NONMEM_LICENSE_STRING=""

USAGE=$(printf "Usage: %s: [-j major_version] [-n minor_version] [-t patch_version] [-l license_string] zip_password\\\\n e.g. %s -j %s -n %s -t %s -l my_license my_password\\\n or e.g. %s my_password" $0 $0 ${NONMEM_MAJOR_VERSION} ${NONMEM_MINOR_VERSION} ${NONMEM_PATCH_VERSION} $0)


while getopts ?l:j:n:t: name; do
  case $name in
  j) NONMEM_MAJOR_VERSION=$OPTARG;;
  n) NONMEM_MINOR_VERSION=$OPTARG;;
  t) NONMEM_PATCH_VERSION=$OPTARG;;
  l) NONMEM_LICENSE_STRING=$OPTARG;;
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
  --build-arg NONMEM_LICENSE_STRING=${NONMEM_LICENSE_STRING} \
  --build-arg NONMEM_ZIP_PASS=$PASSWORD .
