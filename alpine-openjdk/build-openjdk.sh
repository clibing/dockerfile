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
        
echo "begin build base openjdk."
for JDK_VERSION in ${JDK_VERSIONS}
do
docker buildx build --platform=${TARGET_PLATFORM} --build-arg JDK_VERSION=${JDK_VERSION} -t ${IMAGE_BASE_NAME}:${JDK_VERSION} --push -f Dockerfile .
docker buildx build --platform=${TARGET_PLATFORM} --build-arg JDK_VERSION=${JDK_VERSION} -t ${IMAGE_BASE_NAME}:latest --push -f Dockerfile .
done
echo "successful build base openjdk."

