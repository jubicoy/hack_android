#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "2 arguments required. Exiting ..."
    echo "Usage: ./rename_apk.sh <name slug> <target apk in outputs/apk>"
    exit 1
fi

NAME_SLUG=${1}
TARGET_APK=${2}
TIMESTAMP=$(date +"%Y%m%d")

APK_DIR="app/build/outputs/apk"

mv "${APK_DIR}/${TARGET_APK}" "${APK_DIR}/${NAME_SLUG}_${TIMESTAMP}.apk"