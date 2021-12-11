#!/bin/bash
source fncs.sh

TEST_IMAGE=docker-test:latest
TEST=$1
ARGS=$@

[[ "${ARGS[@]}" =~ "--build" ]] && docker build -t $TEST_IMAGE -f Dockerfile.test .

# awslogin
[[ "${ARGS[@]}" =~ "--login" ]] && docker run --rm \
    -v ~/.npmrc:/root/.npmrc \
    -it \
    --platform=linux/amd64 \
    --env-file=$PWD/.env \
    $TEST_IMAGE /awslogin

function build_simple-project () {
    rm -rf simple-project
    mkdir simple-project
    cp package.simple.json simple-project/package.json
}

function build_local_simple () {
    build_simple-project
    (cd simple-project && yarn install)
}

function docker_build_mount_simple () {
    echo "Run test: yarn install"
    build_simple-project
    docker run --rm \
        -v $PWD/simple-project:/src \
        -v ~/.npmrc:/src/.npmrc \
        -w /src \
        --platform="linux/amd64" \
        --env-file=$PWD/.env \
        $TEST_IMAGE yarn install
}

function docker_build_no_mount_simple () {
    build_simple-project
    docker rm -f docker_build_no_mount_simple || :
    echo "Run test: yarn install"
    docker run -d \
        -w /src \
        --platform="linux/amd64" \
        --env-file=$PWD/.env \
        --name docker_build_no_mount_simple \
        $TEST_IMAGE /bin/bash -c "trap : TERM INT; sleep infinity & wait"
    function build () {
        docker cp $PWD/simple-project/package.json docker_build_no_mount_simple:/src/package.json
        # docker cp ~/.npmrc docker_build_no_mount_simple:/src/.npmrc

        docker exec docker_build_no_mount_simple yarn install
    }
    echo "Timing internal build"
    timeit build
    docker rm -f docker_build_no_mount_simple || :
}

"$TEST"
