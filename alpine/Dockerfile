ARG ALPINE_VERSION="3.9"

FROM alpine:${ALPINE_VERSION}

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ENV TZ "Asia/Shanghai"

ENV LANG="en_US.UTF-8"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

RUN apk upgrade --update \
    && apk add bash tzdata curl wget \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

CMD ["/bin/bash"]
