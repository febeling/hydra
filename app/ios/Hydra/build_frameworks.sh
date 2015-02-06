#!/bin/bash -e

# The directory with repositories of dependencies
REPOSITORIES=`pwd`/../../../..

# The location to create the frameworks in
PREFIX=`pwd`/frameworks

dobuild() {
    if [ ! -d $PREFIX ]; then
        mkdir $PREFIX
    fi

    export PREFIX
    autoframework $package $archive.a --without-makecert
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
