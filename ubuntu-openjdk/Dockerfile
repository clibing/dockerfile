FROM clibing/ubuntu 

MAINTAINER clibing <wmsjhappy@gmail.com> 

ARG JDK_VERSION="8" 

ARG JAVA_OPTS="-XX:+PrintFlagsFinal"

ARG JAVA_GC_LOG="/var/log/jvmgc.log"

ENV JAVA_GC_LOG ${JAVA_GC_LOG}

ENV JAVA_HOME /usr/lib/jvm/default-jvm

# refs => http://calvin1978.blogcn.com/articles/jvmoption-7.html
ENV JAVA_OPTS   -Djava.security.egd=file:/dev/./urandom \
                -XX:AutoBoxCacheMax=20000 \
                -XX:+UnlockExperimentalVMOptions \
                -XX:+UseCGroupMemoryLimitForHeap \
                -XX:+AlwaysPreTouch \
                -XX:+PrintCommandLineFlags \
                -XX:+PrintGCDateStamps \
                -XX:+PrintGCDetails \
                -XX:+PrintGCApplicationStoppedTime \
                -Xloggc:${JAVA_GC_LOG} \
                ${JAVA_OPTS}

RUN apt update -y \
    && apt -qqy install ttf-dejavu fontconfig procps openjdk-${JDK_VERSION}-jdk libnss3 iputils-ping net-tools \
    && ln -s /usr/lib/jvm/java-8-openjdk-* /usr/lib/jvm/default-jvm

RUN rm -rf /var/cache/apk/*
                               
ENV PATH=${JAVA_HOME}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR /workdir

CMD ["/bin/bash"]
