# Author: Bela Ban

#!/bin/bash

DIR=`dirname $0`
LIB=$DIR/../lib
CONF=$DIR/../conf
CLASSES=$DIR/../classes
CP=$CLASSES/:$LIB/*


if [ -f $CONF/log4j2.xml ]; then
    LOG="$LOG -Dlog4j.configurationFile=$CONF/log4j2.xml"
fi;


FLAGS="-Djava.net.preferIPv4Stack=true -server -Xmx1G -Xms500M -XX:+UseG1GC"
JMX="-Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=localhost"

java -cp $CP $LOG $FLAGS $JMX $*

