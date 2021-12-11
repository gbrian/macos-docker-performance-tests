#!/bin/bash
function timeit () {
    echo "Start test"
    start_time=$SECONDS
    $1
    elapsed=$(( SECONDS - start_time ))
    echo ""
    echo "*** Test time taken: $elapsed"
}

export -f timeit