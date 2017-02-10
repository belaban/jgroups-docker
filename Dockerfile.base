
# Use latest Fedora image as the base, change to jboss:base once available
FROM fedora:25

LABEL maintainer Bela Ban <belaban@yahoo.com>

# Update base image
## Disabled because yum update /clean fail: https://github.com/coreos/coreos-overlay/issues/474
#RUN yum -y update && yum clean all


RUN dnf -y install \
    java-1.8.0-openjdk-devel \
    net-tools \
    nc        \
    iputils   \
    git       \
    ant       \
    unzip     \
    which

RUN setcap cap_net_raw,cap_net_admin+p /usr/bin/ping


#CMD clear && cat demos.txt && /bin/bash


