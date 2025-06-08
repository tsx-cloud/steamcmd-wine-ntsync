#!/bin/sh
set -euxo pipefail

if [ "$TARGETARCH" = "arm64" ]; then
    box64=box64
elif [ "$TARGETARCH" = "amd64" ]; then
    box64=""
fi

cat << EOF > /usr/local/bin/wine
#!/bin/sh
WINEPREFIX=~/.wine WINEARCH=win64 $box64 ~/wine/bin/wine "\$@"
EOF

cat << EOF > /usr/local/bin/wineserver
#!/bin/sh
WINEPREFIX=~/.wine WINEARCH=win64 $box64 ~/wine/bin/wineserver \$@
EOF

ln -sf ~/wine/bin/wineboot /usr/local/bin/wineboot
ln -sf ~/wine/bin/winecfg /usr/local/bin/winecfg

chmod +x /usr/local/bin/wine
chmod +x /usr/local/bin/wineserver
chmod +x /usr/local/bin/wineboot
chmod +x /usr/local/bin/winecfg
