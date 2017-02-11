#!/bin/bash

#. set_ip.sh

. `dirname $0`/setenv.sh

`dirname $0`/run.sh -DJGROUPS_EXTERNAL_ADDR=$IP_ADDR org.jgroups.demos.CounterServiceDemo -props $CONF/udp.xml $*
