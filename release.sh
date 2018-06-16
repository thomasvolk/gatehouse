#!/bin/bash

ARCHIVE=gatehouse.tar.gz

if [ ! -f $ARCHIVE ]; then
  echo "archive $ARCHIVE not found!"
  echo "run ./build.sh first"
  exit 1
fi

docker build -f Dockerfile.release -t gatehouse-release .
