#!/bin/sh
set -euxo pipefail

cat << EOF > /usr/local/bin/winebox64
#!/bin/sh
WINEPREFIX=~/.wine WINEARCH=win64 $runx64 ~/wine/bin/wine "\$@"
EOF

ln -s /usr/local/bin/winebox64 /usr/local/bin/wine

cat << EOF > /usr/local/bin/wineserver
#!/bin/sh
WINEPREFIX=~/.wine WINEARCH=win64 $runx64 ~/wine/bin/wineserver \$@
EOF

ln -sf ~/wine/bin/wineboot /usr/local/bin/wineboot
ln -sf ~/wine/bin/winecfg /usr/local/bin/winecfg

chmod +x /usr/local/bin/winebox64
chmod +x /usr/local/bin/wineserver
chmod +x /usr/local/bin/wineboot
chmod +x /usr/local/bin/winecfg
