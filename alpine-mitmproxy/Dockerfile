FROM clibing/alpine

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

RUN apk upgrade --update \
    && apk add --no-cache --virtual build-dependencies python3 py3-pip python3-dev libffi-dev openssl-dev gcc libc-dev make rust cargo \
    && rm -rf /var/cache/apk/*

WORKDIR  /workspace

RUN addgroup -S proxy && adduser -S mitm -G proxy --home /workspace/home

RUN chown -R mitm:proxy /workspace

USER mitm

RUN python3 -m venv /workspace/sdk \
   && source /workspace/sdk/bin/activate \
   && python3 -m ensurepip \
   && python3 -m pip install --upgrade pip \
   && python3 -V && pip -V && pip install mitmproxy -i https://pypi.tuna.tsinghua.edu.cn/simple
# && python3 -V && pip -V && pip install https://snapshots.mitmproxy.org/branches/main/mitmproxy-8.0.0.dev0-py3-none-any.whl

EXPOSE 8080 8081

VOLUME /workspace/home

CMD ["mitmweb", "--web-host", "0.0.0.0"]

