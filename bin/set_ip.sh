
#!/bin/bash
if [ -z ${IP_ADDR} ]
    then 
        export IP_ADDR=`curl http://169.254.169.254/latest/meta-data/local-ipv4`;
        echo "IP_ADDR set to $IP_ADDR"
    else
        echo "already set: $IP_ADDR";
fi



