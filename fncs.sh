#!/bin/bash
function timeit () {
    echo "Start test"
    start_time=$SECONDS
    $1 || :
    elapsed=$(( SECONDS - start_time ))
    echo ""
    echo "*** Test time taken: $elapsed"
}

function exec () {
    if [ "$2" == "1" ]; then
        #VERBOSE
        bash $1
    else 
        bash $1 >/dev/null 2>&1
    fi
}

function log () {
    [ "$2" -eq "1" ] && echo "$1" || :
}

function test () {
    TEST=$1
    [[ "$@" == *"--verbose"* ]] && VERBOSE=1 || VERBOSE=0
    shift
    log "Benchmarking $TEST" $VERBOSE
    log "   Run setup" $VERBOSE
    TEST_FOLDER="./tests/$TEST"
    cd $TEST_FOLDER
    exec "./setup.sh" $VERBOSE

    i=${1:-1}
    TIMES=""
    while [ $i -gt 0 ]
    do
        log "   Test iteration $i" $VERBOSE
        log  "      Run A" $VERBOSE
        start_time=$SECONDS
        exec "./local.sh" $VERBOSE
        A_ELAPSED=$(( SECONDS - start_time ))

        log "       Run B" $VERBOSE
        start_time=$SECONDS
        exec "./docker.sh" $VERBOSE
        B_ELAPSED=$(( SECONDS - start_time ))
        log "       A vs B: $A_ELAPSED - $B_ELAPSED" $VERBOSE

        TIMES="$TIMES $A_ELAPSED - $B_ELAPSED
"
        let "i-=1" 
    done
    echo "Benchmark <$TEST> local vs docker"
    echo "$TIMES"

}
