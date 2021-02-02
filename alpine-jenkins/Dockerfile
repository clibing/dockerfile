FROM clibing/alpine-openjdk

LABEL maintainer="liuboxun <wmsjhappy@gmail.com>"

ARG JENKINS_VERSION=2.263.1

ENV JENKINS_VERSION ${JENKINS_VERSION:-2.263.1}

ADD https://get.jenkins.io/war-stable/${JENKINS_VERSION}/jenkins.war /opt/jenkins.war

RUN chmod 644 /opt/jenkins.war

ENV JENKINS_HOME /jenkins

RUN apk add --update ttf-dejavu fontconfig 

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-Djava.awt.headless=true", "-jar", "/opt/jenkins.war"]

EXPOSE 8080

CMD [""]

