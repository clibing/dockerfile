FROM clibing/alpine

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ARG GITLAB_RUNNER_VERSION=v12.7.0

ENV GITLAB_RUNNER_VERSION ${GITLAB_RUNNER_VERSION}

ENV GITLAB_RUNNER_DOWNLOAD https://gitlab-runner-downloads.s3.amazonaws.com/${GITLAB_RUNNER_VERSION}/binaries/gitlab-runner-linux

RUN addgroup gitlab-runner && \
    adduser -S -G gitlab-runner gitlab-runner

RUN apk update && \
    CURRENT_PLATFORM=$([[ $HARDWARE_NAME = "aarch64" ]] && echo 'arm64' || ([[ $HARDWARE_NAME = "x86_64" ]] && echo 'amd64' || echo 'arm')) && \ 
    wget -O "/usr/bin/gitlab-runner" "${GITLAB_RUNNER_DOWNLOAD}-${CURRENT_PLATFORM}" && \
    chmod a+x /usr/bin/gitlab-runner && \
    mkdir -p /etc/gitlab-runner && \
    chmod 0700 /etc/gitlab-runner && \
    rm -rf /var/cache/apk/*

# Preserve runner's data
VOLUME ["/etc/gitlab-runner", "/home/gitlab-runner"]

# init sets up the environment and launches gitlab-runner
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]

ENTRYPOINT ["/usr/bin/gitlab-runner"]
