#########################################################################
# File Name: build.sh
# Author: clibing
# mail: wmsjhappy@@gmail.com
# Created Time: 一  7/ 6 15:53:25 2020
#########################################################################
#!/bin/bash

source ./version
source ./alpine/version

export TARGET_PLATFORM="linux/386,linux/amd64,linux/arm64/v8,linux/arm/v7,linux/arm/v6"

echo "begin build base alpine."
docker buildx build --platform=${TARGET_PLATFORM} --build-arg ALPINE_VERSION=${ALPINE_VERSION} -t ${IMAGE_BASE_NAME}:${ALPINE_VERSION} --push -f ${PROJECT_NAME}/Dockerfile .
docker buildx build --platform=${TARGET_PLATFORM} --build-arg ALPINE_VERSION=${ALPINE_VERSION} -t ${IMAGE_BASE_NAME}:latest --push -f ${PROJECT_NAME}/Dockerfile .
echo "successful build base alpine."
