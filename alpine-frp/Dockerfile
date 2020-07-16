FROM clibing/alpine

ARG FRP_VERSION=0.21.0

ENV FRP_VERSION ${FRP_VERSION}

ENV FRP_HOME        "/opt/frp"

# frps
ENV FRPS_BIN        "${FRP_HOME}/frps"
ENV FRPS_CONF       "${FRP_HOME}/frps_default.ini"
ENV FRPS_LOG        "${FRP_HOME}/frps_.log"

# frpc
ENV FRPC_BIN        "${FRP_HOME}/frpc"
ENV FRPC_CONF       "${FRP_HOME}/frpc_default.ini"
ENV FRPC_LOG        "${FRP_HOME}/frpc_.log"

# https://github.com/fatedier/frp/releases/download/v0.33.0/frp_0.33.0_linux_386.tar.gz
ENV DOWNLOAD_URL    https://github.com/fatedier/frp/releases/download

RUN set -ex \
    && apk add --no-cache pcre \
    && CURRENT_PLATFORM=$([[ $HARDWARE_NAME = "aarch64" ]] && echo 'arm64' || ([[ $HARDWARE_NAME = "x86_64" ]] && echo 'amd64' || echo 'arm')) \
    && wget ${DOWNLOAD_URL}/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_${CURRENT_PLATFORM}.tar.gz \   
    && tar -xzvf frp_${FRP_VERSION}_linux_${CURRENT_PLATFORM}.tar.gz \   
    && cd frp_${FRP_VERSION}_linux_${CURRENT_PLATFORM} \   
    && [ ! -d ${FRP_HOME} ] && mkdir -p ${FRP_HOME} \
    && mv frps frpc frps.ini frpc.ini ${FRP_HOME}/ \
    && cd .. \
    && rm -rf frp_${FRP_VERSION}_linux_${CURRENT_PLATFORM}.tgr.gz frp_${FRP_VERSION}_linux_${CURRENT_PLATFORM} 

VOLUME ${FRP_HOME}

EXPOSE 80 443 5443 5444 5443 5445

ADD entrypoint.sh ${FRP_HOME}/entrypoint.sh

RUN chmod +x ${FRP_HOME}/entrypoint.sh ${FRP_HOME}/frpc ${FRP_HOME}/frps

ENV PATH $PATH:${FRPS_BIN}:${FRPC_BIN}:.

WORKDIR ${FRP_HOME}

ENTRYPOINT ["entrypoint.sh"]

