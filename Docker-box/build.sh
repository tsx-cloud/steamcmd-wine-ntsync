#!/bin/bash

ARCH=$(uname -m)

if [[ "$ARCH" == "aarch64" ]]; then
    echo "Building for ARM64..."
    docker build -t tsxcloud/steamcmd-wine-ntsync:10.15-arm64-box .
elif [[ "$ARCH" == "x86_64" ]]; then
    echo "Building for AMD64..."
    docker build --build-arg RUNX64="" -t tsxcloud/steamcmd-wine-ntsync:10.15-amd64 .
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi
