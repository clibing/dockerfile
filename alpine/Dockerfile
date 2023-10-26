ARG ALPINE_VERSION="3.9"

FROM alpine:${ALPINE_VERSION}

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ENV TZ "Asia/Shanghai"

ENV LANG="en_US.UTF-8"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

#    && apk add bash tzdata curl wget tini \
RUN apk upgrade --update \
    && apk add bash tzdata curl wget \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

# NOTE
#
# https://github.com/krallin/tini.git
# NOTE: If you are using Docker 1.13 or greater, Tini is included in Docker itself. 
# This includes all versions of Docker CE. To enable Tini, just pass the --init flag to docker run.
#
# docker run --rm -it --init alpine sh
# docker-compose.yaml
# ```yaml
# version: '3'
# services:
#   web:
#     image:..
#     init: true  # 设置为true
# ```
#
# top
# 1     0 root     S     1112   0%   1   0% /sbin/docker-init -- sh
#
# ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/bin/bash"]
