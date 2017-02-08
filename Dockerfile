
# Use latest Fedora image as the base, change to jboss:base once available
FROM fedora:20

MAINTAINER Bela Ban <belaban@yahoo.com>

# Update base image
## Disabled because yum update /clean fail: https://github.com/coreos/coreos-overlay/issues/474
#RUN yum -y update && yum clean all

RUN yum -y install \
    java-1.8.0-openjdk-devel \
    net-tools \
    nc \
    unzip \
    which

# Create a user and group used to launch processes
# The user ID 1000 is the default for the first "regular" user on Fedora/RHEL,
# so there is a high chance that this ID will be equal to the current user
# making it easier to use volumes (no permission issues)
RUN groupadd -r jgroups -g 1000
RUN useradd -u 1000 -r -g jgroups -m -d /opt/jgroups -s /sbin/nologin -c "jgroups user" jgroups

RUN echo root:root | chpasswd 
RUN echo jgroups:jgroups | chpasswd

ENV HOME /opt/jgroups
ENV JGROUPS_VERSION 4.0.0.CR2
ENV JAVA_HOME /usr/lib/jvm/java
ENV PATH $PATH:$HOME/bin

# Set the HOME env variable
WORKDIR /opt/jgroups

RUN mkdir $HOME/bin
RUN mkdir $HOME/lib


# Exposes ports used by JGroups
## EXPOSE port1 port2 .. port-n


COPY README.md  $HOME/
COPY demos.txt  $HOME/
COPY udp.xml    $HOME/
COPY log4j2.xml $HOME/
COPY probe.sh   $HOME/bin/
COPY jgroups.sh $HOME/bin/
COPY chat.sh    $HOME/bin/chat
COPY lock.sh    $HOME/bin/lock
COPY count.sh   $HOME/bin/count

RUN chown -R jgroups.jgroups $HOME/*

# Run everything below as the jgroups user. Unfortunately, USER is only observed by RUN, 
# *not* by ADD or COPY !!
USER jgroups

RUN cd $HOME/lib && curl -k -L -O \
https://search.maven.org/remotecontent?filepath=org/apache/logging/log4j/log4j-core/2.7/log4j-core-2.7.jar && \
curl -k -L -O https://search.maven.org/remotecontent?filepath=org/apache/logging/log4j/log4j-api/2.7/log4j-api-2.7.jar

RUN chmod u+x $HOME/bin/*
RUN cd lib && curl -ksS -L -O https://sourceforge.net/projects/javagroups/files/JGroups/$JGROUPS_VERSION/jgroups-$JGROUPS_VERSION.jar



#CMD ["/bin/bash", "-c cat $HOME/README.md"]
# CMD /bin/bash -c "cat $HOME/README.md"
#CMD /bin/bash
#CMD echo "To run the demos, please read README.md" && /bin/bash
CMD clear && cat demos.txt && /bin/bash


