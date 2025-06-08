## Base information
This image is based on Ubuntu 25.04 and Wine 10.9 with all the latest features — staging, TKG, NTSync, and WoW64. Additionally, wine-mono and vcrun 2022 (Visual C++ 2022 Redistributable) are preinstalled.
This Docker build is designed to be compatible with https://github.com/steamcmd/docker

## ARM64
ARM64 compatibility is provided by Box64.

## DockerHUB
https://hub.docker.com/r/tsxcloud/steamcmd-wine-ntsync

## Usage
Pull latest image
```yaml
docker pull tsxcloud/steamcmd-wine-ntsync:latest
```
Test interactively
```yaml
docker run --entrypoint /bin/bash -it tsxcloud/steamcmd-wine-ntsync:latest
```

An example of usage can be seen with the game V Rising. https://github.com/tsx-cloud/vrising-ntsync

##
Enjoying the project? A ⭐ goes a long way!
