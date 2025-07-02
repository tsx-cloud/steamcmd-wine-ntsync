#!/bin/bash
set -euxo pipefail

if [ "$TARGETARCH" = "amd64" ]; then
    echo "Skipping box64 install on amd64"
    exit 0
fi

# Add repo box64 to source list and install box64
wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list
wget -qO- https://ryanfortner.github.io/box64-debs/KEY.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/box64-debs-archive-keyring.gpg
apt update
apt install box64 -y
