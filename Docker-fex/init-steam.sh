#!/usr/bin/env bash
set -euo pipefail

#32-bit libs for Steam
dpkg --add-architecture armhf
apt update
apt install -y libc6:armhf libpthread-stubs0-dev:armhf libncurses6:armhf libstdc++6:armhf


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
