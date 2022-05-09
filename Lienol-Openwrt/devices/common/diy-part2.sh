#!/bin/bash

function git_sparse_clone() {
branch="$1" rurl="$2" localdir="$3" && shift 3
git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
cd $localdir
git sparse-checkout init --cone
git sparse-checkout set $@
mv -n $@ ../
cd $GITHUB_WORKSPACE/openwrt
rm -rf $localdir
}

sed -i "/CONFIG_VERSION_NUMBER=/d" .config
sed -i "/CONFIG_VERSION_DIST=/a\CONFIG_VERSION_NUMBER=\"$REPO_BRANCH\"" .config
sed -i "/CONFIG_VERSION_CODE=/d" .config
sed -i "/CONFIG_VERSION_NUMBER=/a\CONFIG_VERSION_CODE=\"$RELEASE_CODE\"" .config
sed -i "/CONFIG_VERSION_MANUFACTURER=/d" .config
sed -i "/CONFIG_VERSION_CODE=/a\CONFIG_VERSION_MANUFACTURER=\"$OP_MANUFACTURER\"" .config

sed -i "//etc\/opkg\/distfeeds.conf/d" package/default-settings/files/zzz-default-settings
sed -i "/DISTRIB_DESCRIPTION=/a\sed -i '/DISTRIB_GITHUB/d' /etc/openwrt_release" package/default-settings/files/zzz-default-settings
sed -i "/DISTRIB_GITHUB/a\echo \"DISTRIB_GITHUB=\'https://github.com/zhuxiaole/Build-OpenWrt\'\" >> /etc/openwrt_release" package/default-settings/files/zzz-default-settings
sed -i "/DISTRIB_DESCRIPTION=/a\sed -i '/DISTRIB_MY_TARGET/d' /etc/openwrt_release" package/default-settings/files/zzz-default-settings
sed -i "/DISTRIB_MY_TARGET/a\echo \"DISTRIB_MY_TARGET=\'$MY_BUILD_TARGET\'\" >> /etc/openwrt_release" package/default-settings/files/zzz-default-settings

rm -rf package/base-files/files/etc/banner
cp $GITHUB_WORKSPACE/$OP_MANUFACTURER/devices/common/banner package/base-files/files/etc/

rm -rf package/feeds/luci/luci-theme-argon/htdocs/luci-static/argon/favicon.ico
rm -rf package/feeds/luci/luci-theme-argon/htdocs/luci-static/argon/img/argon.svg
rm -rf package/feeds/luci/luci-theme-argon/htdocs/luci-static/argon/icon/android-icon-*.png
rm -rf package/feeds/luci/luci-theme-argon/htdocs/luci-static/argon/icon/apple-icon-*.png
rm -rf package/feeds/luci/luci-theme-argon/htdocs/luci-static/argon/icon/favicon-*.png
rm -rf package/feeds/luci/luci-theme-argon/htdocs/luci-static/argon/icon/ms-icon-*.png
cp $GITHUB_WORKSPACE/$OP_MANUFACTURER/devices/common/argon/favicon.ico package/feeds/luci/luci-theme-argon/htdocs/luci-static/argon/
cp $GITHUB_WORKSPACE/$OP_MANUFACTURER/devices/common/argon/argon.svg package/feeds/luci/luci-theme-argon/htdocs/luci-static/argon/img/
cp $GITHUB_WORKSPACE/$OP_MANUFACTURER/devices/common/argon/icon/* package/feeds/luci/luci-theme-argon/htdocs/luci-static/argon/icon/
