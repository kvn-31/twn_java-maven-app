#!/usr/bin/env bash

export IMAGE=$1
export TAG=$2
docker-compose -f docker-compose.yaml up --detach
echo "success"
