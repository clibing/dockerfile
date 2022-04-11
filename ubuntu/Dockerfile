ARG UBUNTU_VERSION="20.04"

FROM ubuntu:${UBUNTU_VERSION} 

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ENV TZ "Asia/Shanghai"

ENV LANG="en_US.UTF-8"

RUN apt update -y \
    && apt -qqy install bash tzdata curl wget unzip gnupg git\
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN echo "Asia/Shanghai" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

CMD ["/bin/bash"]
