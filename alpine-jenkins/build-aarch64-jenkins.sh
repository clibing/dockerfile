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

echo "begin build base jenkins."
docker buildx build --no-cache \
    --platform="linux/arm64/v8" \
    -t ${IMAGE_BASE_NAME}:${VERSION}-aarch64 \
    --build-arg MAVEN_VERSION=${MAVEN_VERSION} \
    --build-arg JENKINS_VERSION=${VERSION}  \
    --push -f Dockerfile.aarch64 .

