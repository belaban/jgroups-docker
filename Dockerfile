
# Use latest Fedora image as the base
FROM fedora:latest


# Update base image
## Disabled because yum update /clean fail: https://github.com/coreos/coreos-overlay/issues/474
#RUN yum -y update && yum clean all

RUN yum -y install java-1.8.0-openjdk-devel

# Create a user and group used to launch processes
# The user ID 1000 is the default for the first "regular" user on Fedora/RHEL,
# so there is a high chance that this ID will be equal to the current user
# making it easier to use volumes (no permission issues)
RUN groupadd -r jboss -g 1000
RUN useradd -u 1000 -r -g jboss -m -d /opt/jboss -s /sbin/nologin -c "JBoss user" jboss

# Set the HOME env variable
ENV HOME /opt/jboss


# Set the JAVA_HOME variable to make it clear where Java is located
ENV JAVA_HOME /usr/lib/jvm/java

# Set the HOME env variable
WORKDIR /opt/jboss


# Run everything below as the jboss user
USER jboss

CMD ["/bin/bash"]
