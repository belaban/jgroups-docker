#!/bin/bash

DIR=`dirname $0`

java -cp $DIR/RelayServer.jar org.jgroups.demos.Chat -props $DIR/relay3.xml $*
