#!/bin/bash

sed -i "s/hostname='OpenWrt'/hostname='ZXLWrt'/g" package/base-files/files/bin/config_generate
sed -i "s/timezone='UTC'/timezone='CST-8'/" package/base-files/files/bin/config_generate

rm -rf package/base-files/files/etc/banner
cp $GITHUB_WORKSPACE/devices/common/banner package/base-files/files/etc/

rm -rf package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/favicon.ico
rm -rf package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/img/argon.svg
rm -rf package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/icon/android-icon-*.png
rm -rf package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/icon/apple-icon-*.png
rm -rf package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/icon/favicon-*.png
rm -rf package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/icon/ms-icon-*.png
cp $GITHUB_WORKSPACE/devices/common/argon/favicon.ico package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/
cp $GITHUB_WORKSPACE/devices/common/argon/argon.svg package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/img/
cp $GITHUB_WORKSPACE/devices/common/argon/icon/* package/feeds/zhuxiaole/luci-theme-argon/htdocs/luci-static/argon/icon/
