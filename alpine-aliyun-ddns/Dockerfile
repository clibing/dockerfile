FROM golang:alpine3.12 as builder
ENV CGO_ENABLED=0
RUN apk add --update git curl

RUN mkdir -p $GOPATH/src/golang.org/x  \
    && cd $GOPATH/src/golang.org/x  \
    && git clone https://github.com/golang/crypto.git \
	&& git clone https://github.com/golang/net.git \
	&& git clone https://github.com/golang/sys.git

RUN set -ex && \
    go get -u -v \
        -ldflags "-X main.version=$(curl -ksSL https://api.github.com/repos/chenhw2/aliyun-ddns-cli/commits/master | \
            sed -n '{/sha/p; /date/p;}' | sed 's/.* \"//g' | cut -c1-10 | tr '[:lower:]' '[:upper:]' | sed 'N;s/\n/@/g' | head -1)" \
        github.com/chenhw2/aliyun-ddns-cli

FROM clibing/alpine

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

# /usr/bin/aliyun-ddns-cli
COPY --from=builder /go/bin /usr/bin

ENV AKID=1234567890 \
    AKSCT=abcdefghijklmn \
    DOMAIN=ddns.example.win \
    IPAPI=[IPAPI-GROUP] \
    REDO=0

CMD aliyun-ddns-cli \
    --ipapi ${IPAPI} \
    auto-update \
    --domain ${DOMAIN} \
    --redo ${REDO}
