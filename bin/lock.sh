#!/bin/bash

#. set_ip.sh

. `dirname $0`/setenv.sh

`dirname $0`/run.sh -DJGROUPS_EXTERNAL_ADDR=$IP_ADDR org.jgroups.demos.LockServiceDemo -props $CONF/udp.xml $*
