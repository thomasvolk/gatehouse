#!/bin/bash

set -e

VERSION=$(cat mix.exs | grep -P 'version: ".+"' | grep -Po '(?<=)(\d+\.\d\.\d)')
echo "build release '$VERSION'"
(cd assets && npm install && ./node_modules/brunch/bin/brunch build) 
docker build -f Dockerfile.build -t gatehouse-build .
docker rm gatehouse-build || true
docker create --name gatehouse-build gatehouse-build
docker cp gatehouse-build:_build/prod/rel/gatehouse/releases/$VERSION/gatehouse.tar.gz .
