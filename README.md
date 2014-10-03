

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
they will form a cluster. Typing a message into one Chat will send it
to all other chats


## Distributed locks

Distributed locks are implementations of
`java.util.concurrent.locks.Lock` and provide locks that can be
accessed from all nodes in a cluster. 

A typical use case is to lock a resource so that only 1 thread in a
given node in the cluster can access it. Should a node crash while
holding a lock, the lock is released immediately.

For more details, see the section on distributed locks at
http://www.jgroups.org/manual/index.html#LockService.

To run the lock demo, type:

       lock [-name  name]

Typing `help` into the shell shows a few commands:

    [jgroups@b21d0fa6c79d ~]$ lock -name A

    -------------------------------------------------------------------
    GMS: address=A, cluster=lock-cluster, physical address=172.17.0.178:52519
    -------------------------------------------------------------------
    : help

    LockServiceDemo [-props properties] [-name name]
    Valid commands:
        lock (<lock name>)+
        unlock (<lock name> | "ALL")+
        trylock (<lock name>)+ [<timeout>]

    Example:
        lock lock lock2 lock3
        unlock all
        trylock bela michelle 300
    :

If you start instances A and B, you can try out the following:

1. A: `lock printer`
2. B: `lock printer`   // will block
3. A: `unlock printer` // now B will get the lock

Or a lock holder can be killed:

1. A: `lock printer`
2. B: `lock printer`
3. Kill A. B will now get the lock on "printer"

    



## Distributed counters

Distributed counters are counters will can be atomically incremented,
decremented, compare-and-set etc *across a cluster*.

To run the demo:

    count [-name name]

Run multiple instances in different containers. The demo uses a
counter named "mycounter" and there's a command prompt which shows the
commands to be executed.


Questions can be asked on the users or dev mailing lists:
https://sourceforge.net/p/javagroups/mailman.

Enjoy !

Bela Ban


