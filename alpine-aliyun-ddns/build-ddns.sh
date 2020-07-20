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
        
echo "begin build aliyun ddns."
docker buildx build --platform=${TARGET_PLATFORM} -t ${IMAGE_BASE_NAME}:latest --push -f Dockerfile .
echo "successful build aliyun ddns."

