#!/bin/bash
WINE_VER="10.12"

docker push tsxcloud/steamcmd-wine-ntsync:${WINE_VER}-arm64-fex

docker manifest create --amend "tsxcloud/steamcmd-wine-ntsync:arm64-fex" \
  tsxcloud/steamcmd-wine-ntsync:${WINE_VER}-arm64-fex

docker manifest push --purge "tsxcloud/steamcmd-wine-ntsync:arm64-fex"
