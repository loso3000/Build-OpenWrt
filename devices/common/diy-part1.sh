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