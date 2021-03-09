#!/bin/bash

set -e

PACKAGE_NAME=gatehouse
VERSION=latest

echo "login"
docker login -u $DOCKER_REGISTRY_USER -p $DOCKER_REGISTRY_API_KEY
echo "tag image"
docker tag gatehouse-release $DOCKER_REGISTRY_USER/$PACKAGE_NAME:$VERSION
echo "push image ..."
docker push $DOCKER_REGISTRY_USER/$PACKAGE_NAME:$VERSION
