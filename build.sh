#!/bin/bash

set -e

echo "build release ..."
docker build -f Dockerfile.build -t gatehouse-build .
docker rm gatehouse-build || true
docker create --name gatehouse-build gatehouse-build
docker cp gatehouse-build:_dist/gatehouse.tar.gz .
