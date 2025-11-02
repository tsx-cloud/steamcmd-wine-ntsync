#!/bin/bash

ARCH=$(uname -m)

if [[ "$ARCH" == "aarch64" ]]; then
    echo "Push arm64-box..."
    docker push tsxcloud/steamcmd-wine-ntsync:10.18-arm64-box
elif [[ "$ARCH" == "x86_64" ]]; then
    echo "Building for amd64..."
    docker push tsxcloud/steamcmd-wine-ntsync:10.18-amd64
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi
