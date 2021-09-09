FROM ubuntu:18.04

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ENV TZ "Asia/Shanghai"

ENV LANG="en_US.UTF-8"

RUN apt update -y \
    && apt -qqy install bash tzdata curl wget unzip openjdk-8-jdk gnupg \
    && apt -qqy install chromium-browser chromium-chromedriver 

RUN echo "Asia/Shanghai" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*

CMD ["/bin/bash"]
