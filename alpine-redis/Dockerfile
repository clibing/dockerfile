FROM clibing/alpine

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ARG REDIS_VERSION
ENV REDIS_VERSION ${REDIS_VERSION:-4.0.6}

ARG GOSU_VERSION
ENV GOSU_VERSION ${GOSU_VERSION:-1.12}

ARG JEMALLOC_VERSION
ENV JEMALLOC_VERSION ${JEMALLOC_VERSION:-5.2.1}

# "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-`dpkg --print-architecture | awk -F- '{ print $NF }'`" \
# https://github.com/tianon/gosu/releases/download/1.12/gosu-amd64

RUN set -exo pipefail \
    && apk update \
    && apk add --no-cache --virtual .build-deps build-base linux-headers openssl autoconf pkgconf \ 
    && HARDWARE_NAME=$(uname -m) \
    && COREDNS_PLATFORM=$([[ $HARDWARE_NAME = "aarch64" ]] && echo 'arm64' || ([[ $HARDWARE_NAME = "x86_64" ]] && echo 'amd64' || echo 'armhf')) \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-${COREDNS_PLATFORM}" \
    && chmod +x /usr/local/bin/gosu \
    && cd /tmp \
    && wget https://github.com/jemalloc/jemalloc/releases/download/${JEMALLOC_VERSION}/jemalloc-${JEMALLOC_VERSION}.tar.bz2 \
    && tar xjf jemalloc-${JEMALLOC_VERSION}.tar.bz2 \
    && cd /tmp/jemalloc-${JEMALLOC_VERSION} \
    && ./autogen.sh \
    && make \
    && make install \
    && cd /tmp \
    && wget https://github.com/antirez/redis/archive/${REDIS_VERSION}.tar.gz \
    && tar xzf ${REDIS_VERSION}.tar.gz \
    && cd /tmp/redis-${REDIS_VERSION} \
    && make \
    && make install \
    && cp redis.conf /etc/redis.conf \
    && sed -i -e 's/bind 127.0.0.1/bind 0.0.0.0/' /etc/redis.conf \
    && adduser -D redis \
    && apk del .build-deps \
    && rm -rf /tmp/*

RUN apk update \
    && apk add libgcc

RUN echo "echo never > /sys/kernel/mm/transparent_hugepage/enabled" >> /etc/rc.local \ 
    && echo "net.core.somaxconn = 1024" >> /etc/sysctl.conf

ADD enabled /sys/kernel/mm/transparent_hugepage/

WORKDIR /data

VOLUME ["/data"]

COPY entrypoint.sh /

EXPOSE 6379

CMD ["redis-server", "/etc/redis.conf"]

ENTRYPOINT ["/entrypoint.sh"]
