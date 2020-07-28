FROM clibing/alpine

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ARG GITLAB_RUNNER_VERSION=v12.7.0

ENV GITLAB_RUNNER_VERSION ${GITLAB_RUNNER_VERSION}

ENV GITLAB_RUNNER_DOWNLOAD https://gitlab-runner-downloads.s3.amazonaws.com/${GITLAB_RUNNER_VERSION}/binaries/gitlab-runner-linux

RUN apk upgrade --update \
    && addgroup gitlab-runner \
    && adduser -S -G gitlab-runner gitlab-runner 

RUN export HARDWARE_NAME="$(uname -m)" \
    && export CURRENT_PLATFORM="$(if [ "$HARDWARE_NAME" = "aarch64" ] ; then echo arm64 ; elif [ "$HARDWARE_NAME" = "x86_64" ] ; then echo amd64 ; else echo arm ; fi)" \
    && echo -e "----------->>>> $CURRENT_PLATFORM \n${GITLAB_RUNNER_DOWNLOAD}-${CURRENT_PLATFORM}" \
    && wget -O "/usr/bin/gitlab-runner" "${GITLAB_RUNNER_DOWNLOAD}-${CURRENT_PLATFORM}"

RUN chmod a+x /usr/bin/gitlab-runner \
    && mkdir -p /etc/gitlab-runner \
    && chmod 0700 /etc/gitlab-runner \
    8& rm -rf /var/cache/apk/*

RUN chmod +x /usr/bin/gitlab-runner

# Preserve runner's data
VOLUME ["/etc/gitlab-runner", "/home/gitlab-runner"]

# init sets up the environment and launches gitlab-runner
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]

ENTRYPOINT ["/usr/bin/gitlab-runner"]
