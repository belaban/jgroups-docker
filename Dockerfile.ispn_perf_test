

FROM belaban/alpine

LABEL maintainer Bela Ban <belaban@yahoo.com>

ENV HOME /opt/jgroups
ENV PATH $PATH:$HOME/IspnPerfTest/bin
WORKDIR /opt/jgroups

# Create a user and group used to launch processes
# The user ID 1000 is the default for the first "regular" user on Fedora/RHEL,
# so there is a high chance that this ID will be equal to the current user
# making it easier to use volumes (no permission issues)
RUN mkdir -p /opt/jgroups \
 && addgroup -S jgroups -g 1000 \
 && adduser -u 1000 -S -G jgroups -h /opt/jgroups -s /sbin/nologin jgroups \
 && echo root:root | chpasswd ; echo jgroups:jgroups | chpasswd \
 && printf "\njgroups ALL=(ALL) NOPASSWD: ALL\n" >> /etc/sudoers

EXPOSE 7800-7900:7800-7900 9000-9100:9000-9100

USER root

### Not supported by docker as of March 2017:
#RUN printf "net.core.rmem_max = 20000000\nnet.core.wmem_max = 10000000\n" >> /etc/sysctl.conf


# Run everything below as the jgroups user:
USER jgroups

## Download JGroups src code and build JAR
RUN git clone https://github.com/belaban/IspnPerfTest.git \
 && cd IspnPerfTest \
 && mvn -DskipTests=true install dependency:go-offline

### mvn -B dependency:resolve dependency:resolve-plugins

RUN chown -R jgroups.jgroups $HOME/* \
    && chmod -R u+x $HOME/*





# ENTRYPOINT ["IspnPerfTest/bin/perf-test.sh", "-nohup"]
# CMD ["-factory ispn", "-cfg IspnPerfTest/conf/dist-sync.xml"]

#CMD $HOME/IspnPerfTest/bin/perf-test.sh -nohup $* &> /tmp/IspnPerfTest.log
## exec replaces the shell with the command so the kill signal can be caught
CMD exec $HOME/IspnPerfTest/bin/perf-test.sh -nohup $*
