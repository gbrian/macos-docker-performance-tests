#!/bin/bash
function timeit () {
    echo "Start test"
    start_time=$SECONDS
    $1 || :
    elapsed=$(( SECONDS - start_time ))
    echo ""
    echo "*** Test time taken: $elapsed"
}

function vs () {
    A=$1
    B=$2
    i="$3"
    TIMES=()
    while [ $i -gt 0 ]
    do
        echo "Test iteration $i"
        echo "Run A"
        start_time=$SECONDS
        ./docker-performance-test.sh $A >/dev/null 2>&1
        A_ELAPSED=$(( SECONDS - start_time ))

        echo "Run B"
        start_time=$SECONDS
        ./docker-performance-test.sh $B >/dev/null 2>&1
        B_ELAPSED=$(( SECONDS - start_time ))
        echo "A vs B: $A_ELAPSED\t$B_ELAPSED"

        TIMES+=("$A_ELAPSED\t$B_ELAPSED")
        let "i-=1" 
    done
    echo "Benchmark A vs B"
    echo ""
    for t in ${TIMES[@]}; do
        echo $t
    done
}

export -f timeit
export -f vs
