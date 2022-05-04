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

mkdir my_hack_patches
git_sparse_clone master "https://github.com/immortalwrt/immortalwrt" "op_patches/5.10_patches" target/linux/generic/hack-5.10
mv op_patches/hack-5.10/952-net-conntrack-events-support-multiple-registrant.patch target/linux/generic/hack-5.10/
mv op_patches/hack-5.10/953-net-patch-linux-kernel-to-support-shortcut-fe.patch target/linux/generic/hack-5.10/
rm -rf op_patches

sed -i "s/hostname='OpenWrt'/hostname='ZXLWrt'/g" package/base-files/files/bin/config_generate
sed -i "s/timezone='UTC'/timezone='CST-8'/" package/base-files/files/bin/config_generate

rm -rf package/base-files/files/etc/banner
cp $GITHUB_WORKSPACE/xwrt/devices/common/banner package/base-files/files/etc/

rm -rf package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/favicon.ico
rm -rf package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/img/argon.svg
rm -rf package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/icon/android-icon-*.png
rm -rf package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/icon/apple-icon-*.png
rm -rf package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/icon/favicon-*.png
rm -rf package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/icon/ms-icon-*.png
cp $GITHUB_WORKSPACE/xwrt/devices/common/argon/favicon.ico package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/
cp $GITHUB_WORKSPACE/xwrt/devices/common/argon/argon.svg package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/img/
cp $GITHUB_WORKSPACE/xwrt/devices/common/argon/icon/* package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/icon/
