#!/bin/bash

set -e

REPOSITORY=pdr
PACKAGE_NAME=gatehouse
NAMESPACE=gatehouse
VERSION=latest
DOCKER_REGISTRY_SERVER=thomasvolk-docker-$REPOSITORY.bintray.io

echo "login"
docker login -u $DOCKER_REGISTRY_USER -p $DOCKER_REGISTRY_API_KEY $DOCKER_REGISTRY_SERVER
echo "tag image"
docker tag gatehouse-release $DOCKER_REGISTRY_SERVER/$NAMESPACE/$PACKAGE_NAME:$VERSION
echo "push image ..."
docker push $DOCKER_REGISTRY_SERVER/$NAMESPACE/$PACKAGE_NAME:$VERSION
