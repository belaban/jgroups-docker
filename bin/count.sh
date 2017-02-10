#!/bin/bash

. set_ip.sh

jgroups.sh -DJGROUPS_EXTERNAL_ADDR=$IP_ADDR org.jgroups.demos.CounterServiceDemo -props $HOME/udp.xml $*
