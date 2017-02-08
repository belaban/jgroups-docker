
# Use belaban/base (contains fedora:25 and some packages)
FROM belaban/base

MAINTAINER Bela Ban <belaban@yahoo.com>


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
ENV JGROUPS $HOME/JGroups
ENV JAVA_HOME /usr/lib/jvm/java
ENV PATH $PATH:$HOME/bin


WORKDIR /opt/jgroups


## Download JGroups src code and build JAR
RUN git clone https://github.com/belaban/JGroups.git
RUN cd $JGROUPS && ant

RUN mkdir $HOME/bin


COPY README.md  $HOME/
COPY demos.txt  $HOME/
COPY udp.xml    $HOME/
COPY log4j2.xml $HOME/
COPY chat.sh    $HOME/bin/chat
COPY lock.sh    $HOME/bin/lock
COPY count.sh   $HOME/bin/count

RUN ln -s /opt/jgroups/JGroups/bin/jgroups.sh /opt/jgroups/bin/jgroups.sh
RUN ln -s /opt/jgroups/JGroups/bin/probe.sh /opt/jgroups/bin/probe.sh

RUN chown -R jgroups.jgroups $HOME/*

# Run everything below as the jgroups user. Unfortunately, USER is only observed by RUN, 
# *not* by ADD or COPY !!
USER jgroups


RUN chmod u+x $HOME/bin/*


CMD clear && cat demos.txt && /bin/bash


