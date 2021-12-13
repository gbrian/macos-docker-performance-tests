#!/bin/bash
export $(cat .env | xargs)
# Dummy docker exec to discard "docker run" time
docker run --rm \
        --platform="linux/amd64" \
        --env-file=$PWD/.env \
        $IMAGE echo "Dummy!"
# LOCAL execution script
echo "Local execution"
bash ./entrypoint.sh