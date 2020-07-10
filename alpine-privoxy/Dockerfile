FROM clibing/alpine

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

RUN apk upgrade --update \
    && apk add privoxy \
    && rm -rf /var/cache/apk/*

ADD config /etc/privoxy/

CMD ["privoxy","--no-daemon","/etc/privoxy/config"]

