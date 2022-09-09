#########################################################################
# File Name: build.sh
# Author: clibing
# mail: wmsjhappy@@gmail.com
# Created Time: 一  7/ 6 15:53:25 2020
#########################################################################
#!/bin/bash

source ../version

unset PROJECT_NAME 
unset IMAGE_BASE_NAME

source ./version

export JDK_TYPE=alpine-openjdk
export JDK_VERSION=11
export TARGET_PLATFORM="linux/amd64,linux/arm64/v8"
echo "begin build base apache maven."
docker buildx build --no-cache --platform=${TARGET_PLATFORM} --build-arg MAVEN_VERSION=${MAVEN_VERSION} -t ${IMAGE_BASE_NAME}:${MAVEN_VERSION} --push -f Dockerfile .
docker buildx build --no-cache --platform=${TARGET_PLATFORM} --build-arg MAVEN_VERSION=${MAVEN_VERSION} -t ${IMAGE_BASE_NAME}:latest --push -f Dockerfile .
echo "successful build apache maven."

