#!/bin/bash
# Install desired Android SDK
OPT_DIR=".sdk"
SDK_DIR="$OPT_DIR/android-sdk-linux"

# Input
SDK_VERSION=${SDK_VERSION:-"r24.3.4"}
BUILD_TOOLS_VERSION=${BUILD_TOOLS_VERSION:-"23.0.1"}
ANDROID_VERSION=${ANDROID_VERSION:-"23"}

SDK_NAME="android-sdk_$SDK_VERSION-linux.tgz"
SDK_URL="http://dl.google.com/android/$SDK_NAME"

ls -alh "$OPT_DIR/"
if [ "$(ls -A ${SDK_DIR})" ]; then
     echo "SDK installed"
     ls -alh ".sdk/android-sdk-linux"
else
    mkdir -p ${OPT_DIR}
    pushd "$OPT_DIR"
    wget "$SDK_URL"
    tar zxvf "$SDK_NAME"
    popd
    ls -alh ${SDK_DIR}
fi
export ANDROID_HOME=".sdk/android-sdk-linux"
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"

expect -c "
set timeout -1   ;
spawn android update sdk -u --filter platform-tool,android-${ANDROID_VERSION},extra-android-m2repository,tool,build-tools-${BUILD_TOOLS_VERSION}; 
expect { 
    \"Do you accept the license\" { exp_send \"y\r\" ; exp_continue }
    eof
}
"
