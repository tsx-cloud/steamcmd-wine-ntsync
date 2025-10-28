WINE_VER="10.17"

docker manifest create --amend "tsxcloud/steamcmd-wine-ntsync:arm64-fex" \
  tsxcloud/steamcmd-wine-ntsync:${WINE_VER}-arm64-fex

docker manifest push --purge "tsxcloud/steamcmd-wine-ntsync:arm64-fex"
