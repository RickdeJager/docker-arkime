#!/bin/bash

set -x
set -e
set -u

SCRIPT="rm -r /tmp/net-*; killall ssh; killall capture"


docker-compose exec arkime bash -c "${SCRIPT}"