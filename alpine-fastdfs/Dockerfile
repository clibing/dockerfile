FROM clibing/alpine

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ARG NGINX_VERSION=1.16.1
ARG LIBFASTCOMMON_VERSION=V1.0.48
ARG FAST_DFS_VERSION=V5.11
ARG FASTDFS_NGX_MODULE=V1.22
ARG BERKELEY_DB_VERSION=18.1.40

ENV NGINX_DOWNLOAD_URL=http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
ENV NGINX_MODULE_DOWNLOAD_URL=https://github.com/happyfish100/fastdfs-nginx-module/archive/${FASTDFS_NGX_MODULE}.tar.gz

ENV FAST_LIB_DOWNLOAD_URL=https://github.com/happyfish100/libfastcommon/archive/${LIBFASTCOMMON_VERSION}.tar.gz
ENV FAST_DFS_DOWNLOAD_URL=https://github.com/happyfish100/fastdfs/archive/${FAST_DFS_VERSION}.tar.gz

ENV FAST_DHT_DOWNLOAD_URL=https://github.com/happyfish100/fastdht/archive/master.zip

RUN apk upgrade --update && apk add perl pcre openssl zlib \
    && apk add --no-cache --virtual .build-deps \
       cmake gcc make libc-dev pcre-dev openssl-dev zlib-dev \
    && curl -fSL ${NGINX_DOWNLOAD_URL} -o /tmp/nginx.tar.gz \
    && curl -fSL ${NGINX_MODULE_DOWNLOAD_URL} -o /tmp/fastdfs_nginx_module.tar.gz \
    && curl -fSL ${FAST_LIB_DOWNLOAD_URL} -o /tmp/libfastcommon.tar.gz \
    && curl -fSL ${FAST_DFS_DOWNLOAD_URL} -o /tmp/fastdfs.tar.gz \
    && curl -fSL ${FAST_DHT_DOWNLOAD_URL} -o /tmp/fastdht.zip \
    && echo "downlaod end."

ADD db-${BERKELEY_DB_VERSION}.tar.gz /tmp/

RUN cd /tmp/db-${BERKELEY_DB_VERSION}/build_unix && ../dist/configure --prefix=/usr && make && make install

RUN cd /tmp \
    && mkdir libfastcommon fastdfs nginx fastdfs_nginx_module \
    && tar -xzvf libfastcommon.tar.gz --strip-components=1 -C libfastcommon \
    && tar -xzvf fastdfs.tar.gz --strip-components=1 -C fastdfs \
    && unzip fastdht.zip && mv fastdht-master fastdht \
    && tar -xzvf nginx.tar.gz --strip-components=1 -C nginx \
    && tar -xzvf fastdfs_nginx_module.tar.gz --strip-components=1 -C fastdfs_nginx_module 

RUN cd /tmp/libfastcommon && sh make.sh && sh make.sh install

RUN cd /tmp/fastdfs && sh make.sh && sh make.sh install

RUN cd /tmp/fastdht && sh make.sh && sh make.sh install

RUN sed 's/\/usr\/local\/include/\/usr\/include\/fastdfs\ \/usr\/include\/fastcommon/g' /tmp/fastdfs_nginx_module/src/config -i \
    && cd /tmp/nginx && ./configure --prefix=/usr/local/nginx --add-module=/tmp/fastdfs_nginx_module/src --with-http_ssl_module --with-http_v2_module && make && make install

RUN apk del .build-deps  \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && echo "build end."

VOLUME /fastdfs/client /fastdfs/tracker /fastdfs/storage /fastdfs/store_path /fastdfs/fastdht /usr/local/nginx/conf /usr/local/nginx/logs

WORKDIR /fastdfs

COPY conf/fdfs/*.* /etc/fdfs/

COPY conf/nginx/mod_fastdfs.conf /etc/fdfs/
COPY conf/nginx/nginx.conf /usr/local/nginx/conf/

COPY conf/fdht/*.conf /etc/fdht/

COPY conf /conf/

COPY entrypoint.sh /

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
