#!/bin/bash
set -euxo pipefail

MONO_VER="10.1.0"
HANGOVER_VER="10.11"
########################################################

echo -e "Downloading Wine..."
mkdir -p wine-installer
cd wine-installer
wget https://github.com/AndreRH/hangover/releases/download/hangover-${HANGOVER_VER}/hangover_${HANGOVER_VER}_ubuntu2404_noble_arm64.tar
tar -xf hangover_${HANGOVER_VER}_ubuntu2404_noble_arm64.tar

echo -e "Installing Wine..."
apt install -y ./hangover-*.deb
cd ..

echo -e "Installing Wine-Mono..."
mkdir -p ~/wine/share/wine/mono
curl -sL -o ~/wine/share/wine/mono/wine-mono-${MONO_VER}-x86.msi \
    "https://dl.winehq.org/wine/wine-mono/${MONO_VER}/wine-mono-${MONO_VER}-x86.msi"

echo -e "Installing Winetricks..."
wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
mv winetricks /usr/local/bin/
