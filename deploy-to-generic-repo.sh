#!/bin/bash

set -e

REPOSITORY=pgr
PACKAGE_NAME=gatehouse.tar.gz
NAMESPACE=gatehouse
VERSION=latest
UPLOAD_URL=https://api.bintray.com/content/thomasvolk/$REPOSITORY/$NAMESPACE/$VERSION/$PACKAGE_NAME

curl -T $PACKAGE_NAME -u"$DOCKER_REGISTRY_USER:$DOCKER_REGISTRY_PASSWORD" $UPLOAD_URL
