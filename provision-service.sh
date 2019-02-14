#!/bin/sh

if [ "$#" -ne 2 ]; then
  echo "Usage $0 CLUSTER NUMBER_OF_TASKS"
  exit 1
fi

aws ecs update-service --cluster $1 --service backend-service --desired-count $2
