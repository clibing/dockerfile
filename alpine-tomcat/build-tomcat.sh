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

echo "begin build base apache tomcat."
docker buildx build --platform=${TARGET_PLATFORM} \
    --build-arg TOMCAT_VERSION=${TOMCAT_VERSION} \
    --build-arg JDK_TYPE=${JDK_TYPE} \
    --build-arg JDK_VERSION=${JDK_VERSION} \
    -t ${IMAGE_BASE_NAME}:${TOMCAT_VERSION} --push -f Dockerfile .
docker buildx build --platform=${TARGET_PLATFORM} \
    --build-arg JDK_TYPE=${JDK_TYPE} \
    --build-arg JDK_VERSION=${JDK_VERSION} \
    --build-arg TOMCAT_VERSION=${TOMCAT_VERSION} \
    -t ${IMAGE_BASE_NAME}:latest --push -f Dockerfile .
echo "successful build apache tomcat."

