ARG JDK_TYPE=alpine-openjdk

ARG JDK_VERSION="latest"

FROM clibing/${JDK_TYPE}:${JDK_VERSION}

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ARG  MAVEN_VERSION=3.6.3

ENV MAVEN_VERSION ${MAVEN_VERSION:-3.6.3}

ENV MAVEN_HOME /usr/local/maven/default-maven

ENV MAVEN_CACHE_DIR /data/repo

ENV NPM_CACHE_DIR /data/npm_cache

ENV NPM_REGISTRY https://registry.npm.taobao.org

ENV NPM_DISTURL https://npm.taobao.org/dist

ENV MAVEN_DOWNLOAD_URL https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz

RUN apk add --no-cache tar unzip \
    && mkdir -p ${MAVEN_HOME} \
    && wget ${MAVEN_DOWNLOAD_URL} \
    && tar -zxf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C ${MAVEN_HOME} --strip-components=1 \
    && ln -s ${MAVEN_HOME}/bin/mvn /usr/local/bin/mvn \
    && apk del tar unzip \
    && rm -rf apache-maven-${MAVEN_VERSION}-bin.tar.gz \
                ${MAVEN_HOME}/bin/*.bat \
                /tmp/*

COPY settings.xml ${MAVEN_HOME}/conf/settings.xml

COPY cmvn /usr/bin/cmvn

RUN chmod a+x /usr/bin/cmvn

VOLUME ${MAVEN_CACHE_DIR}

VOLUME ${NPM_CACHE_DIR}

CMD ["bash"]

