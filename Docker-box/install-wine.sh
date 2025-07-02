#!/bin/bash
set -euxo pipefail

MONO_VER="10.1.0"
WINE_VER="10.11"
WINE_TYPE="staging-tkg-ntsync-amd64-wow64"
########################################################

echo -e "Downloading Wine..."
mkdir -p wine-installer
wget -qO- "https://github.com/Kron4ek/Wine-Builds/releases/download/${WINE_VER}/wine-${WINE_VER}-${WINE_TYPE}.tar.xz" | tar -xJ -C wine-installer --strip-components=1

echo -e "Installing Wine..."
mkdir -p ~/wine
rsync -a wine-installer/ ~/wine/

echo -e "Installing Wine-Mono..."
mkdir -p ~/wine/share/wine/mono
curl -sL -o ~/wine/share/wine/mono/wine-mono-${MONO_VER}-x86.msi \
    "https://dl.winehq.org/wine/wine-mono/${MONO_VER}/wine-mono-${MONO_VER}-x86.msi"

echo -e "Installing Winetricks..."
wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
mv winetricks /usr/local/bin/


echo -e "Installing Wine dependencies for box64 ..."
apt-get install -y adduser base-passwd debconf debconf fontconfig-config fonts-croscore fonts-dejavu-core fonts-dejavu-mono fonts-freefont-otf
apt-get install -y fonts-freefont-ttf fonts-liberation fonts-noto-core fonts-noto-mono fonts-texgyre fonts-urw-base35 gcc-13-base iso-codes libacl1 libaom3
apt-get install -y libapparmor1 libasound2-data libasound2t64 libasyncns0 libatomic1 libattr1 libaudit-common libaudit1 libblkid1 libbrotli1
apt-get install -y libbsd0 libbz2-1.0 libc6 libcap-ng0 libcap2 libcap2-bin libcapi20-3t64 libcom-err2 libcrypt1 libcurl4t64
apt-get install -y libdav1d7 libdb5.3t64 libdbus-1-3 libde265-0 libdebconfclient0 libdeflate0 libdrm-common libdrm2 libexif12 libexpat1
apt-get install -y libffi8 libfontconfig1 libfontenc1 libfreetype6 libfribidi0 libgcc-s1 libgd3 libglib2.0-0t64 libgmp10
apt-get install -y libgomp1 libgphoto2-6t64 libgphoto2-port12t64 libgraphite2-3 libgssapi-krb5-2 libgstreamer-plugins-base1.0-0 libgstreamer1.0-0 libharfbuzz0b libheif-plugin-aomdec
apt-get install -y libheif-plugin-dav1d libheif-plugin-libde265 libheif1 libhogweed6 libibverbs1 libidn2-0 libimagequant0 libjbig0 libjpeg-turbo8 libjpeg8
apt-get install -y libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0 libldap-common libldap2 liblerc4 libltdl7 liblzma5 libmd0
apt-get install -y libmount1 libmp3lame0 libmpg123-0t64 libnettle8 libnghttp2-14 libnl-3-200 libnl-route-3-200 libogg0 libopencl-1.2-1 libopencl1
apt-get install -y libopus0 liborc-0.4-0t64 libpam-modules libpam-modules-bin libpam0g libpcap0.8t64 libpcre2-8-0 libpcsclite1 libpng16-16t64 libpsl5t64
apt-get install -y libpulse0 libraqm0 librtmp1 libsasl2-2 libsasl2-modules-db libselinux1 libsemanage-common libsemanage2 libsepol2 libsharpyuv0
apt-get install -y libsndfile1 libssh2-1t64 libssl3t64 libstdc++6 libsystemd0 libtiff6 libudev1 libunistring5 libunwind8 libusb-1.0-0
apt-get install -y libvorbis0a libvorbisenc2 libwayland-client0 libwebp7 libx11-6 libx11-data libx11-xcb1 libxau6 libxcb1
apt-get install -y libxdmcp6 libxext6 libxkbcommon0 libxkbregistry0 libxml2 libxpm4 libz-mingw-w64 libzstd1 lsb-base
apt-get install -y ocl-icd-libopencl1 passwd sysvinit-utils x11-common xfonts-encodings xfonts-utils xkb-data zlib1g

apt-get install -y libcups2t64 libglu1-mesa libgnutls30t64 libgsm1 libncurses6 libodbccr2 libodbc2 libosmesa6 libsane1 libsdl2-2.0-0
apt-get install -y libv4l-0t64 libxcomposite1 libxfixes3 libxi6 libxinerama1 libxrandr2 libxslt1.1 libxxf86vm1

apt-get install -y mesa-utils openssl

apt-get install -y libflac14 login.defs gcc-15-base openssl-provider-legacy gcc-15-base
