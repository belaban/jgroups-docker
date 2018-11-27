#!/bin/sh

# Discovers all UDP-based members running on a certain mcast address (use -help for help)
# Probe [-help] [-addr <addr>] [-port <port>] [-ttl <ttl>] [-timeout <timeout>]

CP=$HOME/jgroups-docker/lib/jgroups-4*.jar

java -cp $CP org.jgroups.tests.Probe $*
