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

echo "begin build base fastdfs."

docker buildx build --platform=${TARGET_PLATFORM} \ 
    --build-arg NGINX_VERSION=1.24.0 \
    --build-arg FASTDFS_NGX_MODULE=V1.24 \
    --build-arg FAST_DFS_VERSION=V6.11.0 \
    --build-arg LIBFASTCOMMON_VERSION=V1.0.71 \
    -t ${IMAGE_BASE_NAME}:latest --push -f Dockerfile .

docker buildx build --platform=${TARGET_PLATFORM} \
    --build-arg NGINX_VERSION=1.24.0 \
    --build-arg FASTDFS_NGX_MODULE=V1.24 \
    --build-arg FAST_DFS_VERSION=V6.11.0 \
    --build-arg LIBFASTCOMMON_VERSION=V1.0.71 \
    -t ${IMAGE_BASE_NAME}:${VERSION} --push -f Dockerfile .

echo "successful build fastdfs."

