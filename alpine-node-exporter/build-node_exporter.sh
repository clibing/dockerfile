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

echo "begin build base node_exporter."
# echo $GITLAB_RUNNER_VERSION
docker buildx build --platform=${TARGET_PLATFORM} --build-arg NODE_EXPORTER_VERSION=${NODE_EXPORTER_VERSION} -t ${IMAGE_BASE_NAME}:${NODE_EXPORTER_VERSION} --push -f Dockerfile .
echo "successful build node_exporter."

