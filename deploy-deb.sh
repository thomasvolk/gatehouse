#!/bin/bash

set -e

PACKAGE_NAME=gatehouse
NAMESPACE=gatehouse
VERSION=$(cat mix.exs | grep -P 'version: ".+"' | grep -Po '(?<=)(\d+\.\d\.\d)')

curl -T gatehouse-$VERSION.deb -uthomasvolk:$DEBIAN_REGISTRY_PASSWORD \
  $DEBIAN_REGISTRY_URL/$PACKAGE_NAME/$VERSION/$NAMESPACE;deb_distribution=wheezy;deb_component=main;deb_architecture=i386,amd64
