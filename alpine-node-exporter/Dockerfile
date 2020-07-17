FROM clibing/alpine

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ARG NODE_EXPORTER_VERSION=1.0.1

ENV NODE_EXPORTER_VERSION ${NODE_EXPORTER_VERSION:-1.0.1}

# iproute2
# ss -ta

#查询域名的信息
# drill blog.csdn.net @8.8.8.8
#根据IP地址，反向查找域名
# drill -x 8.8.8.8 @47.94.71.34
# /v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz

RUN apk add --no-cache drill iproute2 openrc su-exec ca-certificates wait4ports \
    # Disable getty's
    && sed -i 's/^\(tty\d\:\:\)/#\1/g' /etc/inittab \
    && sed -i \
        # Change subsystem type to "docker"
        -e 's/#rc_sys=".*"/rc_sys="docker"/g' \
        # Allow all variables through
        -e 's/#rc_env_allow=".*"/rc_env_allow="\*"/g' \
        # Start crashed services
        -e 's/#rc_crashed_stop=.*/rc_crashed_stop=NO/g' \
        -e 's/#rc_crashed_start=.*/rc_crashed_start=YES/g' \
        # Define extra dependencies for services
        -e 's/#rc_provide=".*"/rc_provide="loopback net"/g' \
        /etc/rc.conf \
    # Remove unnecessary services
    && rm -f /etc/init.d/hwdrivers \
            /etc/init.d/hwclock \
            /etc/init.d/hwdrivers \
            /etc/init.d/modules \
            /etc/init.d/modules-load \
            /etc/init.d/modloop \
    # Can't do cgroups
    && sed -i 's/\tcgroup_add_service/\t#cgroup_add_service/g' /lib/rc/sh/openrc-run.sh \
    && sed -i 's/VSERVER/DOCKER/Ig' /lib/rc/sh/init.sh

RUN apk upgrade --update \
    && KERNEL_NAME=$(uname -s | awk '{print tolower($0)}') \
    && HARDWARE_NAME=$(uname -m) \
    && CURRENT_PLATFORM=$([[ $HARDWARE_NAME = "aarch64" ]] && echo 'arm64' || ([[ $HARDWARE_NAME = "x86_64" ]] && echo 'amd64' ||([[ $HARDWARE_NAME = "armv7l" ]] && echo 'armv7' || ([[ $HARDWARE_NAME = "armv7l" ]] && echo 'armv7' || echo 'armv6')))) \
    && wget -O target.tar.gz "https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.${KERNEL_NAME}-${CURRENT_PLATFORM}.tar.gz" \
    && tar -zxf target.tar.gz \
    && mkdir -p /etc/node_exporter \
    && mv node_exporter-${NODE_EXPORTER_VERSION}.${KERNEL_NAME}-${CURRENT_PLATFORM}/node_exporter /etc/node_exporter/ \
    && chmod +x /etc/node_exporter/node_exporter \
    && rm -rf /var/cache/apk/* node_exporter-${NODE_EXPORTER_VERSION}.${KERNEL_NAME}-${CURRENT_PLATFORM} target.tar.gz

#RUN addgroup node_exporter && \
#    adduser -S -G node_exporter node_exporter

COPY node_exporter /etc/init.d/

# add exec
RUN chmod +x /etc/init.d/node_exporter  \
#    && mkdir -p /run/openrc \
#    && touch /run/openrc/softlevel \
#&& rc-update add local default \
    && rc-update add node_exporter default 

EXPOSE 9100

CMD ["/sbin/init"]
