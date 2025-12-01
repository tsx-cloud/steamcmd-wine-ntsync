#!/bin/bash
WINE_VER="10.18"

docker push tsxcloud/steamcmd-wine-ntsync:${WINE_VER}-arm64-hangover

docker manifest create --amend "tsxcloud/steamcmd-wine-ntsync:arm64-hangover" \
  tsxcloud/steamcmd-wine-ntsync:${WINE_VER}-arm64-hangover

docker manifest push --purge "tsxcloud/steamcmd-wine-ntsync:arm64-hangover"
