FROM clibing/alpine

LABEL maintainer="liuboxun <wmsjhappy@gmail.com>"

RUN apk upgrade --update \
    && apk add docker \
    && rm -rf /var/cache/apk/*

CMD ["docker","-v"]

