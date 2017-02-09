#!/bin/bash


jgroups.sh -DJGROUPS_EXTERNAL_ADDR=$IP_ADDR org.jgroups.demos.Chat -props $HOME/udp.xml $*

