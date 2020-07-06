#########################################################################
# File Name: build.sh
# Author: clibing
# mail: wmsjhappy@@gmail.com
# Created Time: 一  7/ 6 15:53:25 2020
#########################################################################
#!/bin/bash

source ./version

echo "begin build base alpine."
docker buildx build --platform=${TARGET_PLATFORM} --build-arg ALPINE_VERSION=${ALPINE_VERSION} -t clibing/alpine:${ALPINE_VERSION} --push -f alpine/Dockerfile .
docker buildx build --platform=${TARGET_PLATFORM} --build-arg ALPINE_VERSION=${ALPINE_VERSION} -t clibing/alpine:latest --push -f alpine/Dockerfile .
echo "successful build base alpine."



