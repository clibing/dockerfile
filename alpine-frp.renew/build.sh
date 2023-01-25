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

echo "begin build base frp."

echo "begin build base frpc."
docker buildx build --no-cache --platform=${TARGET_PLATFORM_v8} --build-arg TAG=${TAG} -t ${IMAGE_BASE_NAME}:${TAG} --push -f Dockerfile-for-frpc .
docker buildx build --no-cache --platform=${TARGET_PLATFORM_v8} --build-arg TAG=${TAG} -t ${IMAGE_BASE_NAME}:latest --push -f Dockerfile-for-frpc .

echo "begin build base frps."
docker buildx build --no-cache --platform=${TARGET_PLATFORM_v8} --build-arg TAG=${TAG} -t ${IMAGE_BASE_NAME}:${TAG} --push -f Dockerfile-for-frps .
docker buildx build --no-cache --platform=${TARGET_PLATFORM_v8} --build-arg TAG=${TAG} -t ${IMAGE_BASE_NAME}:latest --push -f Dockerfile-for-frps .
echo "successful build frp."

