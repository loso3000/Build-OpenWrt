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


#自定义x-wrt/packages
git clone --depth 1 -b $REPO_BRANCH https://github.com/x-wrt/packages diy/packages
rm -rf diy/packages/net/smartdns
rm -rf diy/packages/net/frp
rm -rf diy/packages/net/adguardhome
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/packages" "diy/packages/net/smartdns_pkg" net/smartdns
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/packages" "diy/packages/net/frp_pkg" net/frp
git_sparse_clone master "https://github.com/kiddin9/openwrt-packages" "diy/packages/net/adguardhome_pkg" adguardhome


#自定义x-wrt/luci
git clone --depth 1 -b $REPO_BRANCH https://github.com/x-wrt/luci diy/luci
rm -rf diy/luci/applications/luci-app-nft-qos
rm -rf diy/luci/applications/luci-app-dawn
rm -rf diy/luci/applications/luci-app-airplay2
rm -rf diy/luci/applications/luci-app-smartdns
rm -rf diy/luci/applications/luci-app-frpc
rm -rf diy/luci/applications/luci-app-opkg
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "diy/luci/applications/nft_qos_luci" applications/luci-app-nft-qos
git_sparse_clone master "https://github.com/coolsnowwolf/luci" "diy/luci/applications/dawn_luci" applications/luci-app-dawn
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "diy/luci/applications/airplay2_luci" applications/luci-app-airplay2
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "diy/luci/applications/smartdns_luci" applications/luci-app-smartdns
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "diy/luci/applications/frpc_luci" applications/luci-app-frpc
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "diy/luci/applications/opkg_luci" applications/luci-app-opkg

sed -i 's|s:tab("limit", "Limit Rate by IP Address")|s:tab("limit", translate("Limit Rate by IP Address"))|' diy/luci/applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua
sed -i 's|s:tab("limitmac", "Limit Rate by Mac Address")|s:tab("limitmac", translate("Limit Rate by Mac Address"))|' diy/luci/applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua
sed -i 's|s:tab("priority", "Traffic Priority")|s:tab("priority", translate("Traffic Priority"))|' diy/luci/applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua
echo -e '\n#: applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua:33' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e 'msgid "Limit Rate by IP Address"' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e 'msgstr "通过IP地址限速"' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e '\n#: applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua:34' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e 'msgid "Limit Rate by Mac Address"' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e 'msgstr "通过MAC地址限速"' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e '\n#: applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua:35' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e 'msgid "Traffic Priority"' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e 'msgstr "流量优先级"' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e '\n#: applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua:33' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po
echo -e 'msgid "Limit Rate by IP Address"' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po
echo -e 'msgstr "通過IP位址限速"' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po
echo -e '\n#: applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua:34' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po
echo -e 'msgid "Limit Rate by Mac Address"' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po
echo -e 'msgstr "通過MAC位址限速"' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po
echo -e '\n#: applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua:35' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po
echo -e 'msgid "Traffic Priority"' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po
echo -e 'msgstr "流量優先權"' >>diy/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po

sed -i 's|entry({ "admin", "dawn" }, firstchild(), "DAWN", 60)|entry({ "admin", "dawn" }, firstchild(), "Configure DAWN", 60)|g' diy/luci/applications/luci-app-dawn/luasrc/controller/dawn.lua
sed -i 's|Map("dawn", "Network Overview", translate("Network Overview"))|Map("dawn", translate("Network Overview"), translate("View Network Overview"))|' diy/luci/applications/luci-app-dawn/luasrc/model/cbi/dawn/dawn_network.lua
sed -i 's|Map("dawn", "Hearing Map", translate("Hearing Map"))|Map("dawn", translate("Hearing Map"), translate("View Hearing Map"))|' diy/luci/applications/luci-app-dawn/luasrc/model/cbi/dawn/dawn_hearing_map.lua


#添加额外软件包
mkdir -p diy/zhuxiaole
git clone --depth 1 https://github.com/destan19/OpenAppFilter diy/zhuxiaole/OpenAppFilter && mv -n `find diy/zhuxiaole/OpenAppFilter/* -maxdepth 0 -type d` diy/zhuxiaole && rm -rf diy/zhuxiaole/OpenAppFilter
git clone --depth 1 https://github.com/brvphoenix/luci-app-wrtbwmon diy/zhuxiaole/wrtbwmon1 && mv -n `find diy/zhuxiaole/wrtbwmon1/* -maxdepth 0 -type d` diy/zhuxiaole && rm -rf diy/zhuxiaole/wrtbwmon1
git clone --depth 1 https://github.com/brvphoenix/wrtbwmon diy/zhuxiaole/wrtbwmon2 && mv -n `find diy/zhuxiaole/wrtbwmon2/* -maxdepth 0 -type d` diy/zhuxiaole && rm -rf diy/zhuxiaole/wrtbwmon2
git clone --depth 1 https://github.com/sirpdboy/luci-app-advanced diy/zhuxiaole/luci-app-advanced
git clone --depth 1 https://github.com/tty228/luci-app-serverchan diy/zhuxiaole/luci-app-serverchan
git clone --depth 1 https://github.com/ntlf9t/luci-app-easymesh diy/zhuxiaole/luci-app-easymesh
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon diy/zhuxiaole/luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config diy/zhuxiaole/luci-app-argon-config
git clone --depth 1 -b packages https://github.com/xiaorouji/openwrt-passwall diy/zhuxiaole/passwall-pkgs && rm -rf diy/zhuxiaole/passwall-pkgs/.github && mv -n `find diy/zhuxiaole/passwall-pkgs/* -maxdepth 0 -type d` diy/zhuxiaole && rm -rf diy/zhuxiaole/passwall-pkgs
git clone --depth 1 -b luci https://github.com/xiaorouji/openwrt-passwall diy/zhuxiaole/passwall-luci && mv -n `find diy/zhuxiaole/passwall-luci/* -maxdepth 0 -type d` diy/zhuxiaole && rm -rf diy/zhuxiaole/passwall-luci
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "diy/zhuxiaole/guest_wifi_luci" applications/luci-app-guest-wifi
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "diy/zhuxiaole/eqos_luci" applications/luci-app-eqos
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/packages" "diy/zhuxiaole/dnsforwarder_pkg" net/dnsforwarder
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/packages" "diy/zhuxiaole/dnsproxy_pkg" net/dnsproxy
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "diy/zhuxiaole/turboacc_luci" applications/luci-app-turboacc
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/packages" "diy/zhuxiaole/uugamebooster_pkg" net/uugamebooster
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "diy/zhuxiaole/uugamebooster_luci" applications/luci-app-uugamebooster
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "diy/zhuxiaole/arpbind_luci" applications/luci-app-arpbind
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "diy/zhuxiaole/usb_printer_luci" applications/luci-app-usb-printer
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "diy/zhuxiaole/accesscontrol_luci" applications/luci-app-accesscontrol
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "diy/zhuxiaole/cifs_mount_luci" applications/luci-app-cifs-mount
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "diy/zhuxiaole/lib_fs_luci" libs/luci-lib-fs
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "diy/zhuxiaole/filetransfer_luci" applications/luci-app-filetransfer
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "diy/zhuxiaole/ramfree_luci" applications/luci-app-ramfree
git_sparse_clone master "https://github.com/kiddin9/openwrt-packages" "diy/zhuxiaole/adguardhome_luci" luci-app-adguardhome

rm -rf diy/zhuxiaole/luci-app-guest-wifi/po/zh_Hans/guest-wifi.po
mv diy/zhuxiaole/luci-app-guest-wifi/po/zh_Hans/luci-app-guest-wifi.po diy/zhuxiaole/luci-app-guest-wifi/po/zh_Hans/guest-wifi.po

sed -i -e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' diy/zhuxiaole/*/Makefile

chmod +x $GITHUB_WORKSPACE/devices/common/convert-translation.sh
bash $GITHUB_WORKSPACE/devices/common/convert-translation.sh -a >/dev/null 2>&1

sed -i 's|src-git-full packages https://github.com/x-wrt/packages.git|src-link packages ../diy/packages|' feeds.conf.default
sed -i 's|src-git-full luci https://github.com/x-wrt/luci.git|src-link luci ../diy/luci|' feeds.conf.default
echo 'src-link zhuxiaole ../diy/zhuxiaole' >>feeds.conf.default