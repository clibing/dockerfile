<<<<<<< HEAD
FROM clibing/ubuntu:22.04

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ENV BL60X_SDK_PATH /build/sdk

RUN apt update -y \
    && apt -qqy install build-essential python3 python3-pip git screen \
    && pip3 install --upgrade pip

RUN ln -s /usr/bin/python3 /usr/bin/python 

RUN mkdir -p /workdir/tools  /workdir/build

WORKDIR /build

VOLUME /build/src /build/sdk
=======
FROM clibing/ubuntu

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

RUN apt update -y \
    && apt -qqy install build-essential python3 python3-pip git screen 

RUN mkdir -p /workdir/build

WORKDIR  /workdir/build

CMD ["bash"]

>>>>>>> 88e12dfca79c9387c44bd3028883a437f2db9ae9
