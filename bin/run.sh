# Author: Bela Ban

#!/bin/bash

DIR=`dirname $0`
LIB=$DIR/../lib
CONF=$DIR/../conf
CLASSES=$DIR/../classes
CP=$CLASSES/:$LIB/*


if [ -f $CONF/log4j2.xml ]; then
    LOG="$LOG -Dlog4j.configurationFile=$CONF/log4j2.xml"
fi;


FLAGS="-Djava.net.preferIPv4Stack=true -server -Xmx1G -Xms500M -XX:+UseG1GC"

props=udp.xml
#aws=false
bucket=mybucket
main=org.jgroups.demos.Chat

while [ $# -gt 0 ]
do
    case $1 in
    -h|--help)
        printf "\n$0 [-h] [-a] [-props JGroups config file] [-b S3 bucket name] [-r S3 region] [-name node name]\n\
           (-a: run on AWS)\n\n"
        exit 1
        ;;
    -p|-props)
        props=$2
        shift
        ;;
    -n|-name)
        name=$2;
        shift;
        ;;
    -a)
        aws=true
        ;;
    -b)
        bucket=$2
        shift
        ;;
    -r)
        region=$2;
        shift;
        ;;
    (-*)
         echo "$0: error - unrecognized option $1" 1>&2;
         exit 1
         ;;
    (*)
        main=$1
        ;;
    esac
    shift
done

if [[ $aws ]];
   then
       ext_addr=`curl http://169.254.169.254/latest/meta-data/local-ipv4`;
       printf "Running on AWS: external address is %s\n" $ext_addr
       FLAGS="$FLAGS -DJGROUPS_EXTERNAL_ADDR=$ext_addr"
fi

if [[ $region ]];
    then
        export REGION="-DS3_REGION=$region"
fi

executable="java $REGION -DS3_BUCKET=$bucket -cp $CP $LOG $FLAGS $main -props $CONF/$props"

if [[ $name ]];
    then
        executable="$executable -name $name"
fi

echo $executable

