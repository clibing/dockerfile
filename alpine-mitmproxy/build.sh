#########################################################################
# File Name: build.sh
# Author: clibing
# mail: wmsjhappy@@gmail.com
# Created Time: 一  7/ 6 15:53:25 2020
#########################################################################
#!/bin/bash

set -e

source ../version

unset PROJECT_NAME 
unset IMAGE_BASE_NAME

source ./version


echo "begin build mitmproxy."
docker buildx build \
    --no-cache \
    --platform="linux/amd64,linux/arm64/v8" \
    -t ${IMAGE_BASE_NAME}:${VERSION} --push -f Dockerfile .
echo "successful build mitmproxy."

