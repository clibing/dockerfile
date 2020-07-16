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

echo "begin build base frp server and client."
# echo $GITLAB_RUNNER_VERSION
docker buildx build --platform=${TARGET_PLATFORM} --build-arg FRP_VERSION=${FRP_VERSION} -t ${IMAGE_BASE_NAME}:v${FRP_VERSION} --push -f Dockerfile .
echo "successful build frp server and client."

