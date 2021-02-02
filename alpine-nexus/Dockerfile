ARG JDK_TYPE=alpine-openjdk
ARG JDK_VERSION="latest"

FROM clibing/${JDK_TYPE}:${JDK_VERSION}

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ENV SONATYPE_DIR /usr/local/sonatype
ENV SONATYPE_WORK ${SONATYPE_DIR}/sonatype-work
ENV NEXUS_VERSION 3.29.2-02
ENV NEXUS_HOME ${SONATYPE_DIR}/nexus
ENV NEXUS_DATA /data/nexus-data
ENV NEXUS_CONTEXT ''
ENV JAVA_MAX_MEM 1024m 
ENV JAVA_MIN_MEM 1024m
ENV EXTRA_JAVA_OPTS ""

RUN apk upgrade --no-cache \
    && apk add --no-cache tar \
    && mkdir -p ${SONATYPE_DIR} ${SONATYPE_WORK} ${NEXUS_DATA} \
    && wget --no-check-certificate https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz \
    && tar -zxvf nexus-${NEXUS_VERSION}-unix.tar.gz \
    && mv nexus-${NEXUS_VERSION} ${NEXUS_HOME} \
    && sed -e '/^nexus-context/ s:$:${NEXUS_CONTEXT}:' -i ${NEXUS_HOME}/etc/nexus-default.properties \
    && ln -s ${NEXUS_DATA} ${SONATYPE_WORK}/nexus3 \
    && apk del tar \
    && rm -rf /var/cache/apk/*

WORKDIR ${NEXUS_HOME}

VOLUME ${NEXUS_DATA}

EXPOSE 8081

CMD ["bin/nexus","run"]
