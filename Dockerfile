
# Use belaban/alpine (contains minimal alpine/openjdk and some packages)
FROM belaban/alpine

LABEL maintainer Bela Ban <belaban@yahoo.com>


# Create a user and group used to launch processes
# The user ID 1000 is the default for the first "regular" user on Fedora/RHEL,
# so there is a high chance that this ID will be equal to the current user
# making it easier to use volumes (no permission issues)
RUN mkdir -p /opt/jgroups
RUN addgroup -S jgroups -g 1000
RUN adduser -u 1000 -S -G jgroups -h /opt/jgroups -s /sbin/bash jgroups
RUN echo root:root | chpasswd ; echo jgroups:jgroups | chpasswd

RUN printf "\njgroups ALL=(ALL) NOPASSWD: ALL\n" >> /etc/sudoers

EXPOSE 7800-7900:7800-7900 9000-9100:9000-9100

ENV HOME /opt/jgroups
#ENV JAVA_HOME /usr/lib/jvm/java
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


