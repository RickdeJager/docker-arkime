#!/bin/bash

set -x
set -e
set -u

echo "Environment file:"
cat .env
sudo sysctl -w vm.max_map_count=262144
sudo chown -R 1000:1000 es_data
docker-compose up
