FROM ubuntu:25.10

ARG DEBIAN_FRONTEND="noninteractive"
ARG TARGETARCH
ENV TARGETARCH=${TARGETARCH}
ARG RUNX64="box64"
ENV runx64=${RUNX64}

# Install essential tools
RUN apt-get update
RUN apt-get install --yes wget build-essential git curl unzip rsync tar unar libc6 libstdc++6 file ca-certificates gnupg squashfs-tools software-properties-common

# Install optional tools for convenience
RUN apt-get install --yes mc nano unzip file gnupg lsof kmod ack sudo

# Add Unicode support
RUN apt-get install -y locales \
 && locale-gen en_US.UTF-8 \
 && update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# `cabextract` is required by winetricks to install most libraries
# `xvfb` is needed to run Wine with a virtual display, since some Windows programs require a display (used with `xvfb-run`)
RUN apt install --yes cabextract xvfb

###Wine block
ENV WINEPREFIX=/root/.wine
ENV WINEARCH=win64

# Install Wine and Winetricks
COPY install-wine.sh /
RUN bash /install-wine.sh \
 && rm /install-wine.sh

# Install box64
COPY install-box.sh /
RUN bash /install-box.sh \
 && rm /install-box.sh

COPY wrap-wine.sh /
RUN bash /wrap-wine.sh \
 && rm /wrap-wine.sh

# Suppress Wine debug messages
ENV WINEDEBUG=-all
ENV BOX64_LOG=0

# Configure xvfb
ENV DISPLAY=:0
ENV XDG_DATA_DIRS=/root/wine/share:/usr/local/share:/usr/share
ENV XDG_RUNTIME_DIR="/run/user/$(id -u)"
RUN mkdir -p "$XDG_RUNTIME_DIR"
RUN chmod 700 "$XDG_RUNTIME_DIR"

# winegstreamer sometimes causes a bug that prevents Wineprefix creation; this command removes it
#RUN apt-get remove --purge libges-1.0-0

#fex-emu not good for winetricks
RUN xvfb-run winetricks -q vcrun2022

###Steam block
COPY init-steam.sh /
RUN bash /init-steam.sh  \
 && rm /init-steam.sh

# Clean up
RUN apt-get -y autoremove \
 && apt-get clean autoclean \
 && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists

WORKDIR /root

COPY benchmarks/ ./benchmarks/

# Set default command
ENTRYPOINT ["steamcmd"]
CMD ["+help", "+quit"]
