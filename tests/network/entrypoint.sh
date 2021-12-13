#!/bin/bash

COUNT=5
while [[ $COUNT -gt 0 ]]; do
    curl -sL https://speed.hetzner.de/100MB.bin > test.data
    rm test.data
    let "COUNT-=1"
done