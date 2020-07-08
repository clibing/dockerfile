FROM clibing/alpine

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ARG COREDNS_VERSION=1.7.0


RUN set -ex \
    && addgroup coredns \
    && adduser -S -G coredns coredns \
    && apk upgrade --update \
    && apk add 'su-exec>=0.2' \
    && apk add --virtual .fetch-deps \
        ca-certificates \
        outils-sha256 \
        openssl \
        dpkg \
        tar \
    && KERNEL_NAME=$(uname -s | awk '{print tolower($0)}') \
    && echo "----------->>>> KERNEL_NAME: $KERNEL_NAME" \
    && HARDWARE_NAME=$(uname -m) \
    && COREDNS_PLATFORM=$([[ $HARDWARE_NAME = "aarch64" ]] && echo 'arm64' || ([[ $HARDWARE_NAME = "x86_64" ]] && echo 'amd64' || echo 'arm')) \
    && echo "----------->>>> COREDNS_PLATFORM: $COREDNS_PLATFORM" \
    && wget -O coredns.tar.gz "https://github.com/coredns/coredns/releases/download/v${COREDNS_VERSION}/coredns_${COREDNS_VERSION}_${KERNEL_NAME}_${COREDNS_PLATFORM}.tgz" \
    && wget -O coredns.tar.gz.asc "https://github.com/coredns/coredns/releases/download/v${COREDNS_VERSION}/coredns_${COREDNS_VERSION}_${KERNEL_NAME}_${COREDNS_PLATFORM}.tgz.sha256" \
    && SHA256_VALUE=$(cat coredns.tar.gz.asc | awk '{print $1}') \
    && echo "${SHA256_VALUE} *coredns.tar.gz"| sha256sum -c - \
    && tar -zxf coredns.tar.gz \
    && mv coredns /usr/bin/ \
    && mkdir -p /etc/coredns \
    && apk del .fetch-deps \
    && rm -rf coredns.tar.gz coredns.tar.gz.asc

RUN apk add drill

ADD Corefile /etc/coredns/

ADD core.hosts /etc/coredns/

RUN chown -R coredns /etc/coredns /usr/bin/coredns

EXPOSE 53/udp

CMD ["/usr/bin/coredns", "-conf", "/etc/coredns/Corefile"]


