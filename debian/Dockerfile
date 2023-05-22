ARG VERSION="stable-slim"

FROM debian:${VERSION} 

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ENV TZ "Asia/Shanghai"

ENV LANG="en_US.UTF-8"

# fix tzdata selecet and confirm to quit
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt update -y \
    && apt -qqy install bash tzdata curl wget unzip gnupg git tini lsb-release\
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN echo "Asia/Shanghai" > /etc/timezone \
    && rm /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  \  
    && dpkg-reconfigure -f noninteractive tzdata

CMD ["/bin/bash"]
