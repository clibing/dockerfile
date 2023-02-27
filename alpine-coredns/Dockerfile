FROM golang:1.19 AS building

ARG COREDNS_VERSION="v1.10.0"

RUN git clone -b $COREDNS_VERSION  https://github.com/coredns/coredns.git /building

WORKDIR /building

ENV GOPROXY https://goproxy.cn,https://proxy.golang.org,direct

RUN make 

# ---------------------------------------------------------------------------------
FROM clibing/alpine

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

COPY --from=building /building/coredns /usr/bin/coredns

RUN set -ex \
    && addgroup coredns \
    && adduser -S -G coredns coredns \
    && apk upgrade --update \
    && apk add 'su-exec>=0.2' drill \
    && mkdir -p /etc/coredns

ADD Corefile /etc/coredns/

ADD core.hosts /etc/coredns/

RUN chown -R coredns /etc/coredns /usr/bin/coredns

EXPOSE 53/udp

CMD ["/usr/bin/coredns", "-conf", "/etc/coredns/Corefile"]
