#!/bin/bash

set -e

VERSION=$(cat mix.exs | grep -P 'version: ".+"' | grep -Po '(?<=)(\d+\.\d\.\d)')

DEB_DIR=_build/content
PACKAGE=gatehouse-$VERSION.deb
TAR_ARCHIVE=_build/prod/rel/gatehouse/releases/$VERSION/gatehouse.tar.gz

test -f $TAR_ARCHIVE

rm -f $PACKAGE
rm -rf $DEB_DIR
mkdir -p $DEB_DIR/DEBIAN
mkdir -p $DEB_DIR/opt/gatehouse
(cd $DEB_DIR/opt/gatehouse && tar xfz ../../../../$TAR_ARCHIVE)

cat > $DEB_DIR/DEBIAN/control << EOF
Package: gatehouse
Version: $VERSION
Section: dev
Priority: optional
Architecture: all
Essential: no
Maintainer: Thomas Volk <info@thomasvolk.de>
Description: gatehouse
Provides: gatehouse
EOF

dpkg -b $DEB_DIR _build/$PACKAGE
