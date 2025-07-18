#!/usr/bin/env bash
set -euo pipefail

if [ "$TARGETARCH" = "arm64" ]; then
    dpkg --add-architecture armhf
    apt update
    apt install -y libc6:armhf libpthread-stubs0-dev:armhf libncurses6:armhf libstdc++6:armhf
elif [ "$TARGETARCH" = "amd64" ]; then
    dpkg --add-architecture i386
    apt update
    apt install -y libc6:i386 libpthread-stubs0-dev:i386 lib32gcc-s1 lib32stdc++6 lib32z1 libncurses6:i386
fi


mkdir -p ~/steamcmd

curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
  | tar -xz -C ~/steamcmd
chmod +x ~/steamcmd/steamcmd.sh

cat <<EOF >/usr/local/bin/steamcmd
#!/bin/bash
exec $runx64 "$HOME/steamcmd/steamcmd.sh" "\$@"
EOF

cat <<EOF >/usr/local/bin/steamcmd.sh
#!/bin/bash
exec $runx64 "$HOME/steamcmd/steamcmd.sh" "\$@"
EOF

chmod +x /usr/local/bin/steamcmd
chmod +x /usr/local/bin/steamcmd.sh

# Run SteamCMD once to allow it to self-update and create folders
steamcmd +quit

mkdir -p ~/.steam
chmod -R 777 ~/.steam
ln -sf ~/steamcmd/linux32 ~/.steam/sdk32
ln -sf ~/steamcmd/linux64 ~/.steam/sdk64

ln -sf ~/.steam/sdk32/steamclient.so ~/.steam/sdk32/steamservice.so
ln -sf ~/.steam/sdk64/steamclient.so ~/.steam/sdk64/steamservice.so
