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

echo "begin build base nexus oss."
docker buildx build --no-cache=true \
    --platform=${TARGET_PLATFORM_v8} \
    --build-arg NEXUS_VERSION=${NEXUS_VERSION} \
    --build-arg JDK_VERSION=${JDK_VERSION} \
    -t ${IMAGE_BASE_NAME}:${NEXUS_VERSION} --push -f Dockerfile .
docker buildx build \
    --platform=${TARGET_PLATFORM_v8} \
    --build-arg NEXUS_VERSION=${NEXUS_VERSION} \
    --build-arg JDK_VERSION=${JDK_VERSION} \
    -t ${IMAGE_BASE_NAME}:latest --push -f Dockerfile .
echo "successful build nexus oss."

