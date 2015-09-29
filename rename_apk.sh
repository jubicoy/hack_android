#!/bin/bash

function usage () {
    echo "Usage: ./rename_apk.sh <target apk in outputs/apk> <name slug> [<hash>]"
    exit 1
}

if [ "$#" -lt 2 ]; then
    echo "2 arguments required. Exiting ..."
    usage
fi

if [ "$#" -qt 3 ]; then
    echo "Too many arguments. Exiting ..."
    usage
fi

NAME_SLUG=${1}
TARGET_APK=${2}
HASH=${3:0:7}
TIMESTAMP=$(date +"%Y%m%d")

APK_DIR="app/build/outputs/apk"

mv "${APK_DIR}/${TARGET_APK}" "${APK_DIR}/${NAME_SLUG}-${TIMESTAMP}-${HASH}.apk"