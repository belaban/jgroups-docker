#!/bin/bash

. `dirname $0`/setenv.sh

FLAGS="-Djava.net.preferIPv4Stack=true -server -Xmx1G -Xms500M -XX:+UseG1GC"
DEBUG="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8787"

java -cp $CP $DEBUG org.jgroups.docker.EchoServer $*
