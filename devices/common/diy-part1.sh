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

sed -i 's|https://github.com/x-wrt/packages.git|https://github.com/zhuxiaole/x-wrt-packages.git|' feeds.conf.default
sed -i 's|https://github.com/x-wrt/luci.git|https://github.com/zhuxiaole/x-wrt-luci.git|' feeds.conf.default
echo 'src-git zhuxiaole https://github.com/zhuxiaole/my-packages-for-x-wrt' >>feeds.conf.default

#添加fullconenat
rm -rf package/network/config/firewall
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/immortalwrt" "package/network/config/firewall_pkg" package/network/config/firewall
git clone --depth 1 -b dev https://github.com/llccd/openwrt-fullconenat package/network/utils/fullconenat
git_sparse_clone openwrt-18.06 "https://github.com/immortalwrt/immortalwrt" "target/linux/generic/hack-4.19/patch_952" target/linux/generic/hack-4.19/952-net-conntrack-events-support-multiple-registrant.patch
git_sparse_clone master "https://github.com/coolsnowwolf/lede" "target/linux/generic/hack-5.10/patch_952" target/linux/generic/hack-5.10/952-net-conntrack-events-support-multiple-registrant.patch
git_sparse_clone master "https://github.com/coolsnowwolf/lede" "target/linux/generic/hack-5.15/patch_952" target/linux/generic/hack-5.15/952-add-net-conntrack-events-support-multiple-registrant.patch
git_sparse_clone master "https://github.com/coolsnowwolf/lede" "target/linux/generic/hack-5.4/patch_952" target/linux/generic/hack-5.4/952-net-conntrack-events-support-multiple-registrant.patch