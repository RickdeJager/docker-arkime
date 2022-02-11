#!/bin/bash

set -x
set -e
set -u

RUSER="pi"
INTERFACE="any"
FIFO="/tmp/net-$1"
SCRIPT="mkfifo ${FIFO} && \
    ssh ${RUSER}@$1 tcpdump -i ${INTERFACE} -U -s0 -w - 'not port 22' \
"

#    /opt/arkime/bin/capture --copy -r ${FIFO} & \

docker-compose exec arkime bash -c "${SCRIPT}"