FROM clibing/ubuntu-openjdk

LABEL maintainer="clibing <wmsjhappy@gmail.com>"

ARG MAVEN_VERSION=3.6.3

ARG JENKINS_VERSION=2.303.1

ENV JENKINS_VERSION ${JENKINS_VERSION:-2.263.1}

ENV JENKINS_HOME /jenkins

ENV MAVEN_VERSION ${MAVEN_VERSION:-3.6.0}

ENV MAVEN_HOME /usr/local/maven/default-maven

ENV MAVEN_CACHE_DIR /data/repo

ENV MAVEN_DOWNLOAD_URL https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz

ENV NPM_CACHE_DIR /data/npm_cache

ENV NPM_REGISTRY https://registry.npm.taobao.org

ENV NPM_DISTURL https://npm.taobao.org/dist

ENV DEBIAN_FRONTEND noninteractive

# 默认当项目中有go.mod文件就用go mod管理，没有就还是旧的方式，GO111MODULE=on强制使用go mod，GO111MODULE=off关闭go mod
ENV GO111MODULE "on"

# GOPROXY设置代理，我建议设置成与我上面一致，第一个地址是七牛云的代理，防止被墙，direct值得是从源站下载
ENV GOPROXY "https://goproxy.cn,https://proxy.golang.org,https://goproxy.io,direct" 

# 指示校验和服务器的地址和公钥，这里指"sum.golang.org"的公钥可省略，若要关闭校验，GOSUMDB=off。
ENV GOSUMDB "sum.golang.org" 

ENV GOPATH "/workdir/go"

# ENV GOBIN=$GOPATH/bin
#RUN go get -u -v github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway 
#RUN go get -u -v github.com/golang/protobuf/protoc-geon-go

RUN echo "BUILDPLATFORM: $BUILDPLATFORM"

RUN echo "INSTALL: Dep, go python nodejs... other dep"
RUN apt update -y && apt install -qqy tar postfix git golang python3 ca-certificates nodejs npm gcc libprotobuf-dev protobuf-compiler apt-transport-https curl software-properties-common 

RUN echo "INSTALL: Docker"
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
# RUN curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | gpg --dearmor --yes -o /usr/share/keyrings/docker-archive-keyring.gpg \
#    && chmod a+r /usr/share/keyrings/docker-archive-keyring.gpg \
RUN add-apt-repository "deb [arch=$(uname -m)] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \ 
    && apt update -y && apt -qqy install docker postfix \
    && rm -rf /var/lib/apt/lists/*
#    && add-apt-repository "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/$(. /etc/os-release; echo $ID) $(lsb_release -cs) stable" \ 


RUN echo "INSTALL: Maven"
RUN mkdir -p ${MAVEN_HOME} \
    && wget ${MAVEN_DOWNLOAD_URL} \
    && tar -zxf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C ${MAVEN_HOME} --strip-components=1 \
    && ln -s ${MAVEN_HOME}/bin/mvn /usr/local/bin/mvn \
    && rm -rf apache-maven-${MAVEN_VERSION}-bin.tar.gz ${MAVEN_HOME}/bin/*.bat /tmp/* 

COPY settings.xml ${MAVEN_HOME}/conf/settings.xml

COPY cmvn /usr/bin/cmvn

COPY cnpm /usr/bin/cnpm

RUN chmod a+x /usr/bin/cmvn /usr/bin/cnpm

ADD https://get.jenkins.io/war-stable/${JENKINS_VERSION}/jenkins.war /opt/jenkins.war

RUN chmod 644 /opt/jenkins.war

VOLUME ${MAVEN_CACHE_DIR}

VOLUME ${NPM_CACHE_DIR}

EXPOSE 8080

WORKDIR /workdir

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-Djava.awt.headless=true", "-jar", "/opt/jenkins.war"]
