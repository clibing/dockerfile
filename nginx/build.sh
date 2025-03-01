#########################################################################
# File Name: build.sh
# Author: clibing
# mail: wmsjhappy@@gmail.com
# Created Time: 一  7/ 6 15:53:25 2020
#########################################################################
#!/bin/bash

source ../version

export  ENABLE_HUB_CUSTOM="${CUSTOM_PREFIX}"
unset   PROJECT_NAME 
unset   IMAGE_BASE_NAME

source ./version
        
echo "begin build base nginx."

docker buildx build --platform=${TARGET_PLATFORM} --build-arg NGX_VERSION=${NGX_VERSION} -t ${IMAGE_BASE_NAME}:${NGX_VERSION} --push -f Dockerfile .
docker buildx build --platform=${TARGET_PLATFORM} --build-arg NGX_VERSION=${NGX_VERSION} -t ${IMAGE_BASE_NAME}:latest --push -f Dockerfile .
echo "successful build base nginx."

