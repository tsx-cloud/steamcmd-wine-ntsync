#!/bin/bash
set -euxo pipefail

MONO_VER="10.3.0"
########################################################

echo -e "Installing Wine-Mono..."
mkdir -p ~/wine/share/wine/mono
curl -sL -o ~/wine/share/wine/mono/wine-mono-${MONO_VER}-x86.msi \
    "https://dl.winehq.org/wine/wine-mono/${MONO_VER}/wine-mono-${MONO_VER}-x86.msi"

echo -e "Installing Winetricks..."
wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
mv winetricks /usr/local/bin/

mkdir -p /root/.fex-emu/RootFS/
wget -O /root/.fex-emu/RootFS/Ubuntu_25_10.sqsh https://github.com/tsx-cloud/steamcmd-wine-ntsync/releases/latest/download/Ubuntu_25_10.sqsh
unsquashfs -d /root/.fex-emu/RootFS/Ubuntu_25_04 /root/.fex-emu/RootFS/Ubuntu_25_10.sqsh
rm /root/.fex-emu/RootFS/Ubuntu_25_10.sqsh
echo '{"Config":{"RootFS":"Ubuntu_25_10"}}' > /root/.fex-emu/Config.json

mkdir -p /root/wine/
mkdir -p /lib/wine/
cp -a /root/.fex-emu/RootFS/Ubuntu_25_10/opt/wine-staging/. /root/wine/
rm -rf /root/.fex-emu/RootFS/Ubuntu_25_10/opt/wine-staging/
