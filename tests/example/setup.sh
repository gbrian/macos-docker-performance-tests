#!/bin/bash
export $(cat .env | xargs)
# BUILD script
echo "Buiding docker image: $IMAGE"
docker build -t $IMAGE -f ../Dockerfile.base .