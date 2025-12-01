#!/bin/sh
set -euxo pipefail

cat << EOF > /usr/local/bin/winefex-emu
#!/bin/sh
WINEPREFIX=~/.wine WINEARCH=win64 FEX ~/wine/bin/wine "\$@"
EOF

ln -s /usr/local/bin/winefex-emu /usr/local/bin/wine

cat << EOF > /usr/local/bin/wineserver
#!/bin/sh
WINEPREFIX=~/.wine WINEARCH=win64 FEX ~/wine/bin/wineserver \$@
EOF

ln -sf ~/wine/bin/wineboot /usr/local/bin/wineboot
ln -sf ~/wine/bin/winecfg /usr/local/bin/winecfg

chmod +x /usr/local/bin/winefex-emu
chmod +x /usr/local/bin/wineserver
chmod +x /usr/local/bin/wineboot
chmod +x /usr/local/bin/winecfg
