#!/bin/bash -e

BASE_DIR=$(cd "$(dirname "$0")"; pwd)

# Directory with repositories of dependencies
REPOSITORIES=$BASE_DIR/../../../..

# Templates and other resources
RESOURCES=$BASE_DIR/build_frameworks

# The location to create the frameworks in
PREFIX=$BASE_DIR/frameworks

dobuild() {
    if [ ! -d $PREFIX ]; then
        mkdir $PREFIX
    fi

    export PREFIX
    autoframework $package $archive.a --without-makecert

    # Provide a minimal Info.plist to bundle
    SRC=$RESOURCES/Info.plist.template
    DST=$PREFIX/Frameworks/$package.framework/Info.plist

    PRODUCT_NAME=$package
    COPYRIGHT="(c) 2006-2015, ZeroMQ Contributors"
    INFO_STRING="iOS Framework of $package, Universal build"
    BUNDLE_EXECUTABLE=$package

    sed -e "s/{PRODUCT_NAME}/${PRODUCT_NAME}/" \
        -e "s/{COPYRIGHT}/${COPYRIGHT}/"       \
        -e "s/{INFO_STRING}/${INFO_STRING}/"   \
        -e "s/{BUNDLE_EXECUTABLE}/${BUNDLE_EXECUTABLE}/" \
        < "${SRC}"                             \
        > "${DST}"
}

for package in libsodium libzmq czmq zyre; do
    echo =======================================================================
    echo
    echo =====   $package
    echo
    echo =======================================================================

    if [ $package == "czmq" ]; then
        archive="libczmq"
    elif [ $package == "zyre" ]; then
        archive="libzyre"
    else
        archive=$package
    fi
    
    cd "$REPOSITORIES/$package"
    dobuild
done
