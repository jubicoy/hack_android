#!/bin/bash
export ANDROID_HOME="${BUILD_DIR:-$(pwd)}/.sdk/android-sdk-linux"
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"
