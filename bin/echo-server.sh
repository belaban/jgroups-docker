#!/bin/bash

. `dirname $0`/setenv.sh

java -cp $CP org.jgroups.docker.EchoServer $*
