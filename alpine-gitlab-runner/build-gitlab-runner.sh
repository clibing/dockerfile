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

echo "begin build base gitlab runner."
# echo $GITLAB_RUNNER_VERSION
# docker buildx build --platform=${TARGET_PLATFORM} --build-arg GITLAB_RUNNER_VERSION=${GITLAB_RUNNER_VERSION} -t ${IMAGE_BASE_NAME}:${GITLAB_RUNNER_VERSION} --push -f Dockerfile .
docker buildx build --no-cache --platform=${TARGET_PLATFORM} --build-arg GITLAB_RUNNER_VERSION=${GITLAB_RUNNER_VERSION} -t ${IMAGE_BASE_NAME}:${GITLAB_RUNNER_VERSION} --push -f Dockerfile .
echo "successful build gitlab runner ."

