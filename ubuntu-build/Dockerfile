ARG VERSION=23.04

FROM ubuntu:${VERSION:-latest}

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ENV TZ "Asia/Shanghai"

ENV LANG="en_US.UTF-8"

ENV GO111MODULE auto

ENV GOPROXY https://goproxy.cn,direct

RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ lunar main restricted universe multiverse" > /etc/apt/sources.list
RUN echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ lunar main restricted universe multiverse" >> /etc/apt/source.list
RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ lunar-updates main restricted universe multiverse" >> /etc/apt/source.list
RUN echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ lunar-updates main restricted universe multiverse" >> /etc/apt/source.list
RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ lunar-backports main restricted universe multiverse" >> /etc/apt/source.list
RUN echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ lunar-backports main restricted universe multiverse" >> /etc/apt/source.list
RUN echo "deb http://security.ubuntu.com/ubuntu/ lunar-security main restricted universe multiverse" >> /etc/apt/source.list
RUN echo "deb-src http://security.ubuntu.com/ubuntu/ lunar-security main restricted universe multiverse" >> /etc/apt/source.list

RUN apt -qyy update  \
    && apt -qy install bash tzdata curl wget gcc make nodejs ca-certificates gnupg \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone

ADD https://go.dev/dl/go1.21.5.linux-amd64.tar.gz /usr/local/go

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && chmod a+r /etc/apt/keyrings/docker.gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt -qyy update && apt -qyy install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


