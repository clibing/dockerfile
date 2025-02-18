#########################################################################
# File Name: build.sh
# Author: clibing
# mail: wmsjhappy@@gmail.com
# Created Time: 一  7/ 6 15:53:25 2020
#########################################################################
#!/bin/bash

source ../version
source ./version


echo "begin build base alpine."
docker buildx build --no-cache --platform=${TARGET_PLATFORM_v8} --build-arg ENVOY_VERSION=${ENVOY_VERSION} -t ${CUSTOM_PREFIX}${IMAGE_BASE_NAME}:${ENVOY_VERSION} --push -f Dockerfile .
echo "successful build base alpine."
