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

echo "build frp server and client."
# docker buildx build --platform=${TARGET_PLATFORM} --build-arg RELEASE=${RELEASE} -t clibing/alpine-frp:server-${RELEASE} --push -f Dockerfile.frps .

docker buildx build --platform=${TARGET_PLATFORM} --build-arg RELEASE=${RELEASE} -t clibing/alpine-frp:client-${RELEASE} --push -f Dockerfile.frpc .


