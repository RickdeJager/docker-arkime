#!/bin/bash

set -x
set -e
set -u

RUSER="pi"
INTERFACE="any"
FIFO="/tmp/net-$1"
KEY="/tmp/sshkey-$1"
SCRIPT=" \
    set -x ; \
    rm -f ${FIFO} ; \
    mkfifo ${FIFO} && \
    ls ${KEY} || ssh-keygen -b 2048 -t rsa -f ${KEY} -q -N '' && ssh-copy-id -i ${KEY} ${RUSER}@$1 && \ 
    /opt/arkime/bin/capture --copy -r ${FIFO} & \
    ssh -i ${KEY} ${RUSER}@$1 sudo tcpdump -i ${INTERFACE} -U -s0 -w - 'not port 22' > ${FIFO} \
"

docker-compose exec arkime bash -c "${SCRIPT}"