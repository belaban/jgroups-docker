
# Use belaban/base (contains fedora:25 and some packages)
FROM belaban/base

LABEL maintainer Bela Ban <belaban@yahoo.com>


# Create a user and group used to launch processes
# The user ID 1000 is the default for the first "regular" user on Fedora/RHEL,
# so there is a high chance that this ID will be equal to the current user
# making it easier to use volumes (no permission issues)
RUN groupadd -r jgroups -g 1000
RUN useradd -u 1000 -r -g jgroups -m -d /opt/jgroups -s /sbin/nologin -c "jgroups user" jgroups

RUN echo root:root | chpasswd 
RUN echo jgroups:jgroups | chpasswd

ENV HOME /opt/jgroups
ENV JAVA_HOME /usr/lib/jvm/java
ENV PATH $PATH:$HOME/jgroups-docker/bin

WORKDIR /opt/jgroups


## Download JGroups src code and build JAR
RUN git clone https://github.com/belaban/jgroups-docker.git
RUN cd jgroups-docker && ant jar src.jar ## compiles and places JAR in ./dist

RUN chown -R jgroups.jgroups $HOME/*

# Run everything below as the jgroups user. Unfortunately, USER is only observed by RUN, 
# *not* by ADD or COPY !!
USER jgroups


RUN chmod u+x $HOME/*


CMD clear && cat $HOME/jgroups-docker/demos.txt && /bin/bash


