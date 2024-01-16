# log_type all see
# docker build -t clibing/alpine-mosquitto -f Dockerfile.ubuntu .
ARG UBUNTU_VERSION="24.04"

FROM ubuntu:${UBUNTU_VERSION}

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ENV TZ "Asia/Shanghai"

ENV LANG="en_US.UTF-8"

# fix tzdata selecet and confirm to quit
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update -y \
    && apt-get -qqy install bash tzdata curl wget unzip gnupg git tini lsb-release mosquitto \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN echo "Asia/Shanghai" > /etc/timezone \
    && rm /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  \
    && dpkg-reconfigure -f noninteractive tzdata

CMD ["/usr/sbin/mosquitto","-c", "/mosquitto/config/mosquitto.conf"]
