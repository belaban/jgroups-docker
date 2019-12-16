
# Use latest openjdk-lpine image as the base (small footprint)
FROM openjdk:8-jdk-alpine

LABEL maintainer Bela Ban <belaban@yahoo.com>

ENV MAVEN_VERSION 3.5.2
ENV MAVEN_HOME /usr/lib/mvn
ENV PATH $MAVEN_HOME/bin:$PATH

RUN apk update && apk upgrade && apk add --no-cache  \
    apache-ant       \
    bash      \
    bind-tools \
    curl      \
    git       \
    iptables  \
    iputils   \
    netcat-openbsd  \
    net-tools \
    sudo      \
    tcpdump   \
    unzip     \
    which

## This is to fix a libc incompatibility which cause protoc to fail
## Details: https://github.com/sgerrand/alpine-pkg-glibc
RUN apk --no-cache add ca-certificates wget
# RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub
RUN wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.27-r0/glibc-2.27-r0.apk
RUN apk add --allow-untrusted glibc-2.27-r0.apk

## Install maven

RUN wget -q http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
mv apache-maven-$MAVEN_VERSION /usr/lib/mvn




