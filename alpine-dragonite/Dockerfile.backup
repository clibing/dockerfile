FROM clibing/alpine-openjdk

LABEL maintainer "clibing <wmsjhappy@gmail.com>"

ENV DRAGONITE_GITHUB https://github.com/dragonite-network/dragonite-java/releases/download

ENV DRAGONITE_BRANCH fwd-0.4.0-prx-0.4.0

ARG VERSION=0.4.0

ENV DRAGONITE_ECHO_VERSION 0.1.0

ENV DRAGONITE_FORWARDER_VERSION ${VERSION}

ENV DRAGONITE_PROXY_VERSION ${VERSION}

ENV PROXY_HOME /proxy

WORKDIR ${PROXY_HOME} 

# download tar from https://github.com/dragonite-network/dragonite-java/releases
RUN apk upgrade --no-cache \
    && apk add --no-cache curl tar \
    && curl -fSL ${DRAGONITE_GITHUB}/${DRAGONITE_BRANCH}/dragonite-proxy-${DRAGONITE_PROXY_VERSION}.tar -o dragonite-proxy.tar \
    && curl -fSL ${DRAGONITE_GITHUB}/${DRAGONITE_BRANCH}/dragonite-echo-${DRAGONITE_ECHO_VERSION}.tar -o dragonite-echo.tar \
    && curl -fSL ${DRAGONITE_GITHUB}/${DRAGONITE_BRANCH}/dragonite-forwarder-${DRAGONITE_FORWARDER_VERSION}.tar -o dragonite-forwarder.tar \
    && tar -xvf dragonite-proxy.tar -C ${PROXY_HOME}/ --strip-components=1 \
    && tar -xvf dragonite-echo.tar -C ${PROXY_HOME}/ --strip-components=1 \
    && tar -xvf dragonite-forwarder.tar -C ${PROXY_HOME}/ --strip-components=1 \
    && apk del tar curl \
    && rm -rf *.tar \
    && rm -rf /var/cache/apk/*

EXPOSE 152 153 156

ADD docker-entrypoint.sh ./

RUN chmod +x docker-entrypoint.sh

ENTRYPOINT [ "/bin/bash", "docker-entrypoint.sh" ]

