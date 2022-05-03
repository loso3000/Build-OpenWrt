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

git_sparse_clone master "https://github.com/coolsnowwolf/lede" "target/linux/generic/hack-5.10/shortcut_fe_patch/" target/linux/generic/hack-5.10/953-net-patch-linux-kernel-to-support-shortcut-fe.patch
git_sparse_clone master "https://github.com/coolsnowwolf/lede" "target/linux/generic/hack-5.10/shortcut_fe_patch2/" target/linux/generic/hack-5.10/601-netfilter-export-udp_get_timeouts-function.patch
git_sparse_clone master "https://github.com/coolsnowwolf/lede" "target/linux/generic/hack-5.15/shortcut_fe_patch/" target/linux/generic/hack-5.15/953-net-patch-linux-kernel-to-support-shortcut-fe.patch
git_sparse_clone master "https://github.com/coolsnowwolf/lede" "target/linux/generic/hack-5.4/offload_patch/" target/linux/generic/hack-5.4/650-netfilter-add-xt_OFFLOAD-target.patch
git_sparse_clone master "https://github.com/coolsnowwolf/lede" "target/linux/generic/hack-5.4/shortcut_fe_patch/" target/linux/generic/hack-5.4/953-net-patch-linux-kernel-to-support-shortcut-fe.patch
git_sparse_clone master "https://github.com/coolsnowwolf/lede" "target/linux/generic/hack-5.4/shortcut_fe_patch2/" target/linux/generic/hack-5.4/601-netfilter-export-udp_get_timeouts-function.patch

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
