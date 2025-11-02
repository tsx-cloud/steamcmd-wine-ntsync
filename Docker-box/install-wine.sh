#!/bin/bash
set -euxo pipefail

MONO_VER="10.3.0"
WINE_VER="10.18"
WINE_TYPE="staging-tkg-amd64-wow64"
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
apt-get install -y acl libavformat61 libgdk-pixbuf-2.0-0 libnorm1t64 libsane-common libvdpau1 libxinerama1 adwaita-icon-theme libavutil59 libgdk-pixbuf2.0-bin
apt-get install -y libnspr4 libsane1 libvisual-0.4-0 libxkbregistry0 alsa-topology-conf libbdplus0 libgdk-pixbuf2.0-common libnss-mdns libsdl2-2.0-0
apt-get install -y libvorbis0a libvorbisenc2 libxrandr2 alsa-ucm-conf libbluray2 libglu1-mesa libnss3 libshine3 libvorbisfile3 libxshmfence1
apt-get install -y at-spi2-common libcairo-gobject2 libglvnd0 libodbc2 libsnappy1v5 libvpl2 libxtst6 at-spi2-core libcdparanoia0 libgme0
apt-get install -y libodbccr2 libsndfile1 libvpx9 libxvidcore4 dconf-gsettings-backend libchromaprint1 libgpgme11t64 libogg0 libsnmp-base libwayland-client0
apt-get install -y libxxf86vm1 dconf-service libcodec2-1.2 libgphoto2-6t64 libopenjp2-7 libsoxr0 libwayland-cursor0 libzvbi-common gsettings-desktop-schemas libcolord2
apt-get install -y libgphoto2-l10n libopenmpt0t64 libspeex1 libwayland-egl1 libzvbi0t64 gstreamer1.0-plugins-base libcups2t64 libgphoto2-port12t64 libopus0 libspeexdsp1
apt-get install -y libwebpmux3 gtk-update-icon-cache libdaemon0 libgsm1 liborc-0.4-0t64 libsrt1.5-gnutls libx11-xcb1 mesa-libgallium mesa-vdpau-drivers ipp-usb
apt-get install -y libdconf1 libgtk-3-0t64 libpcsclite1 libsvtav1enc2 libx264-164 libx265-215 libaacs0 libdecor-0-0 libgtk-3-bin
apt-get install -y libpgm-5.3-0t64 libswresample5 libxcb-dri3-0 poppler-data libasound2-data libdecor-0-plugin-1-gtk libgtk-3-common libpoppler-glib8t64 libtheoradec1 libxcb-present0
apt-get install -y sane-airscan libasound2-plugins libdrm-amdgpu1 libhwy1t64 libpoppler147 libtheoraenc1 libxcb-randr0 sane-utils libasound2t64 libdrm-intel1
apt-get install -y libieee1284-3t64 libpulse0 libtwolame0 libxcb-sync1 update-inetd vdpau-driver-all libasyncns0 libdvdnav4 libjack-jackd2-0 librabbitmq4
apt-get install -y libudfread0 libxcb-xfixes0 libatk-bridge2.0-0t64 libdvdread8t64 libjxl0.11 librav1e0.7 libv4l-0t64 libxcomposite1 libatk1.0-0t64
apt-get install -y libepoxy0 liblcms2-2 librist4 libv4lconvert0t64 libxcursor1 libatspi2.0-0t64 libexif12 libmbedcrypto16 librsvg2-2 libva-drm2
apt-get install -y libxdamage1 libavahi-core7 libflac14 libmp3lame0 librsvg2-common libva-x11-2 libxfixes3 libavcodec61 libgbm1 libmpg123-0t64
apt-get install -y libsamplerate0 libva2 libxi6

apt-get install -y ocl-icd-libopencl1 passwd sysvinit-utils x11-common xfonts-encodings xfonts-utils xkb-data zlib1g

apt-get install -y  libgnutls30t64  libncurses6 libosmesa6
apt-get install -y  libxinerama1 libxslt1.1

apt-get install -y mesa-utils openssl

apt-get install -y libflac14 login.defs
