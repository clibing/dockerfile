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
<<<<<<< HEAD
docker buildx build --no-cache --platform=${TARGET_PLATFORM_v8} --build-arg JDK_VERSION=${JDK_VERSION} -t ${IMAGE_BASE_NAME}:${JDK_VERSION}-${BUILD_VERSION} --push -f Dockerfile .
docker buildx build --no-cache --platform=${TARGET_PLATFORM_v8} --build-arg JDK_VERSION=${JDK_VERSION} -t ${IMAGE_BASE_NAME}:latest --push -f Dockerfile .
=======
for JDK_VERSION in ${JDK_VERSIONS}
do
docker buildx build --platform=${TARGET_PLATFORM} --build-arg JDK_VERSION=${JDK_VERSION} -t ${IMAGE_BASE_NAME}:${JDK_VERSION} --push -f Dockerfile .
docker buildx build --platform=${TARGET_PLATFORM} --build-arg JDK_VERSION=${JDK_VERSION} -t ${IMAGE_BASE_NAME}:latest --push -f Dockerfile .
done
>>>>>>> 88e12dfca79c9387c44bd3028883a437f2db9ae9
echo "successful build base openjdk."

