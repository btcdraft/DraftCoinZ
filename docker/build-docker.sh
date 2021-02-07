#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

DOCKER_IMAGE=${DOCKER_IMAGE:-dftzpay/dftzd-develop}
DOCKER_TAG=${DOCKER_TAG:-latest}

BUILD_DIR=${BUILD_DIR:-.}

rm docker/bin/*
mkdir docker/bin
cp $BUILD_DIR/src/dftzd docker/bin/
cp $BUILD_DIR/src/dftz-cli docker/bin/
cp $BUILD_DIR/src/dftz-tx docker/bin/
strip docker/bin/dftzd
strip docker/bin/dftz-cli
strip docker/bin/dftz-tx

docker build --pull -t $DOCKER_IMAGE:$DOCKER_TAG -f docker/Dockerfile docker
