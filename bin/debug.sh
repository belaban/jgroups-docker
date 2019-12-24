# Author: Bela Ban

#!/bin/bash

export DEBUG="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8787"

./run.sh $*

