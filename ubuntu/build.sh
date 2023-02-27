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

echo "begin build base ubuntu."
# docker buildx build --no-cahce --platform=${TARGET_PLATFORM_v7} \
docker buildx build --platform=${TARGET_PLATFORM_v7} \
    -t ${IMAGE_BASE_NAME}:${VERSION} \
    --build-arg UBUNTU_VERSION=${VERSION} \
    --push -f Dockerfile .

# docker buildx build --no-cache --platform=${TARGET_PLATFORM_v7} \
docker buildx build  --platform=${TARGET_PLATFORM_v7} \
    --build-arg UBUNTU_VERSION=${VERSION} \
    -t ${IMAGE_BASE_NAME}:latest  \
    --push -f Dockerfile .
echo "successful build ubuntu."

