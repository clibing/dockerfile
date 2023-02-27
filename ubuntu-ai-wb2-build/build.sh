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

echo "begin ai-wb2 build."
docker build -t ${IMAGE_BASE_NAME}:${VERSION} -f Dockerfile .
echo "successful ai-wb2 build." 

