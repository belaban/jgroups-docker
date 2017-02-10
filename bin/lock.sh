#!/bin/bash

. set_ip.sh

jgroups.sh -DJGROUPS_EXTERNAL_ADDR=$IP_ADDR org.jgroups.demos.LockServiceDemo -props $HOME/udp.xml $*
