#!/bin/bash

set -e

VERSION=$(cat mix.exs | grep -P 'version: ".+"' | grep -Po '(?<=)(\d+\.\d\.\d)')
PACKAGE_NAME=gatehouse
NAMESPACE=gatehouse
PACKAGE=gatehouse-$VERSION.deb

curl -T $PACKAGE -uthomasvolk:$DEBIAN_REGISTRY_PASSWORD \
  "$DEBIAN_REGISTRY_URL/$PACKAGE_NAME/$VERSION/$PACKAGE;deb_distribution=wheezy;deb_component=main;deb_architecture=i386,amd64"
