#!/bin/bash -e -x

REPOSITORIES=`pwd`/../../../..
IOS_LIBS=`pwd`/frameworks

for project in libsodium libzmq czmq zyre; do
    cd "$REPOSITORIES/$project"
    make clean
done

rm -rf $IOS_LIBS/*
