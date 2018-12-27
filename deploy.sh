#!/bin/bash -ex
VCS_REF=`git rev-parse --short HEAD`
BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"`
# override DOCKER_TAG with TRAVIS_TAG if set
export DOCKER_TAG=${TRAVIS_TAG:-0.1.0}
docker-compose build
if [ "x$TRAVIS_TAG" == "x" ]; then exit; fi
echo "$DOCKER_PWD" | docker login -u "$DOCKER_USER" --password-stdin
docker-compose push
