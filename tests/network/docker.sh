#!/bin/bash
export $(cat .env | xargs)
# Docker execution script
echo "Docker execution"
docker run --rm \
        --platform="linux/amd64" \
        --env-file=$PWD/.env \
        $IMAGE