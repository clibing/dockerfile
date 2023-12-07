ARG VERSION=1.21

FROM golang:${VERSION:-latest}

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ENV TZ "Asia/Shanghai"

ENV LANG="en_US.UTF-8"

ENV GO111MODULE auto

ENV GOPROXY https://goproxy.cn,direct

RUN apt -qyy update  \
    && apt -qy install bash tzdata curl wget gcc make nodejs \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone
