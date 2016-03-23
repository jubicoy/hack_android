#!/bin/bash -e
export SDK_OPT_DIR="$(pwd)/.sdk"
export ANDROID_HOME="${SDK_OPT_DIR}/android-sdk-linux"
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"

cond-echo () {
  if [ -n $VERBOSE ]; then
    "$@" &> /dev/null
  else
    "$@"
  fi
}

update-sdk () {
  if [ "$#" -ne 1 ]; then
    echo "Missing filter definition. Exiting ..."
    exit 1
  fi
  FILTER="${1}"
  cond-echo expect -c "
set timeout -1   ;
spawn android update sdk -u -a -t ${FILTER};
expect {
    \"Do you accept the license\" { exp_send \"y\r\" ; exp_continue }
    eof
}
"
}

ensure-sdk-version () {
  if [ "$#" -ne 1 ]; then
    echo "Missing SDK version. Exiting ..."
    exit 1
  fi
  SDK_VERSION="${1}"
  SDK_NAME="android-sdk_$SDK_VERSION-linux.tgz"
  SDK_URL="http://dl.google.com/android/$SDK_NAME"

  if [ "$(ls -A ${ANDROID_HOME})" ]; then
       echo "SDK installed"
  else
      cond-echo mkdir -p "${SDK_OPT_DIR}"
      cond-echo pushd "${SDK_OPT_DIR}"
      echo "Downloading ${SDK_NAME} ..."
      cond-echo wget "${SDK_URL}"
      echo "Extracting ..."
      cond-echo tar zxvf "${SDK_NAME}"
      cond-echo popd
      echo "SDK installed"
  fi
}
