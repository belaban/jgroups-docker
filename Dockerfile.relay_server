

FROM belaban/alpine

LABEL maintainer Bela Ban <belaban@yahoo.com>

ENV HOME /opt/jgroups
ENV PATH $PATH:$HOME/RollingUpgrades/bin
WORKDIR /opt/jgroups
ENV RELAY_SERVER_VERSION 1.0.0.Final
ENV REPO https://repository.jboss.org/nexus/service/local/repo_groups/public-jboss/content

## todo: change to the repo below as soon as the update has sync'ed to it
# ENV REPO https://repo1.maven.org/maven2/org/jgroups
ENV JAR relay-server-$RELAY_SERVER_VERSION-jar-with-dependencies.jar
ENV URL $REPO/org/jgroups/rolling-upgrades/relay-server/$RELAY_SERVER_VERSION//$JAR

## https://repository.jboss.org/nexus/service/local/repo_groups/public-jboss/content/org/jgroups/rolling-upgrades/relay-server/1.0.0.Final/relay-server-1.0.0.Final-jar-with-dependencies.jar


# Create a user and group used to launch processes
# The user ID 1000 is the default for the first "regular" user on Fedora/RHEL,
# so there is a high chance that this ID will be equal to the current user
# making it easier to use volumes (no permission issues)
RUN mkdir -p /opt/jgroups/RollingUpgrades/bin \
 && addgroup -S jgroups -g 1000 \
 && adduser -u 1000 -S -G jgroups -h /opt/jgroups -s /sbin/nologin jgroups \
 && echo root:root | chpasswd ; echo jgroups:jgroups | chpasswd \
 && printf "\njgroups ALL=(ALL) NOPASSWD: ALL\n" >> /etc/sudoers

EXPOSE 50051:50051

USER root

COPY settings.xml $HOME/.m2/
COPY relay-server.sh chat.sh relay3.xml RollingUpgrades/bin/
RUN chown -R jgroups.jgroups $HOME/.m2
RUN chown -R jgroups.jgroups $HOME/* \
    && chmod -R u+x $HOME/*

# Run everything below as the jgroups user:
USER jgroups


## Download RelayServer JAR
RUN cd RollingUpgrades/bin \
    && wget -O RelayServer.jar ${URL}





## exec replaces the shell with the command so the kill signal can be caught
CMD exec relay-server.sh $*