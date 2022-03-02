#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt for Amlogic s9xxx tv box
# Function: Diy script (Before Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/openwrt/openwrt / Branch: 21.02
#========================================================================================================================

# Uncomment a feed source
# sed -i 's/#src-git helloworld/src-git helloworld/g' ./feeds.conf.default
# sed -i 's/\"#src-git\"/\"src-git\"/g' feeds.conf.default

# Add a feed source
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

# other
# rm -rf package/lean/{samba4,luci-app-samba4,luci-app-ttyd}

# Replace coolsnowwolf/lede watchcat and luci-app-watchcat with immortalwrt source
rm -rf packages/utils/watchcat
rm -rf luci/applications/luci-app-watchcat
cp -r temp/luci/applications/luci-app-watchcat luci/applications/luci-app-watchcat
cp -r temp/packages/utils/watchcat packages/utils/watchcat
# Remove watchcat config
echo "" > packages/utils/watchcat/files/watchcat.config

# Replace coolsnowwolf/lede php7 with immortalwrt source
rm -rf packages/lang/php7
cp -r temp/packages/lang/php7 packages/lang/php7

# Replace coolsnowwolf/lede perl with immortalwrt source
rm -rf packages/lang/perl
cp -r temp/packages/lang/perl packages/lang/perl

# Clone Lean's feeds
mkdir customfeeds
git clone --depth=1 https://github.com/coolsnowwolf/packages customfeeds/packages
git clone --depth=1 https://github.com/coolsnowwolf/luci customfeeds/luci

# Clone ImmortalWrt's feeds
pushd customfeeds
mkdir temp
git clone --depth=1 https://github.com/immortalwrt/packages -b openwrt-18.06 temp/packages
git clone --depth=1 https://github.com/immortalwrt/luci -b openwrt-18.06-k5.4 temp/luci

