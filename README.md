

# jgroups-docker

Dockerfile for a container containing JGroups and a couple of
demos. 

To run the image directly, execute

      docker -it belaban/jgroups

To build the image, run

      docker build .


The demos are described below. The idea is to run the demo apps in a
container each *on the same host* and they will form a cluster.


## Chat
To run it:

      chat [-name name], e.g. chat -name A

Run the Chat application in multiple containers on the same host and
they will form a cluster. Typing a mesage into one Chat will send it
to all other chats


## Distributed locks

Distributed locks are implementations of
`java.util.concurrent.locks.Lock` and provide locks that can be
accessed from all nodes in a cluster. 

A typical use case is to lock a resource so that only 1 thread in a
given node in the cluster can access it. Should a node crash while
holding a lock, the lock is released immediately.

To run the lock demo, type:

       lock [-name  name]



## Distributed counters



## Traffic across sites



