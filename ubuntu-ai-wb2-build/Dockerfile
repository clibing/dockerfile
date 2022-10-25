FROM clibing/ubuntu

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

RUN apt update -y \
    && apt -qqy install build-essential python3 python3-pip git screen 

RUN mkdir -p /workdir/build

WORKDIR  /workdir/build

CMD ["bash"]

