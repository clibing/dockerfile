#########################################################################
# File Name: build.sh
# Author: clibing
# mail: wmsjhappy@@gmail.com
# Created Time: 一  7/ 6 15:53:25 2020
#########################################################################
#!/bin/bash

set -e

source ../version

unset PROJECT_NAME 
unset IMAGE_BASE_NAME

source ./version

echo "begin build base redis."
docker buildx build \
    --platform=${TARGET_PLATFORM} \
    --build-arg REDIS_VERSION=${REDIS_VERSION} \
    --build-arg GOSU_VERSION=${GOSU_VERSION} \
    --build-arg JEMALLOC_VERSION=${JEMALLOC_VERSION} \
    -t ${IMAGE_BASE_NAME}:${REDIS_VERSION} --push -f Dockerfile .
echo "successful build redis."

