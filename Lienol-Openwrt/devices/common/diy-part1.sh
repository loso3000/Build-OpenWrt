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

rm -rf feeds/packages/net/frp
git clone --depth 1 https://github.com/kuoruan/openwrt-frp feeds/packages/net/frp

rm -rf feeds/packages/net/adguardhome
git_sparse_clone main "https://github.com/kenzok8/small-package" "feeds/packages/net/adguardhome_pkg" adguardhome

rm -rf feeds/packages/net/xray-core
git_sparse_clone packages "https://github.com/xiaorouji/openwrt-passwall" "feeds/packages/net/xray_core_pkg" xray-core

sed -i 's|$(INSTALL_DIR) $(1)/etc/init.d|#$(INSTALL_DIR) $(1)/etc/init.d|' feeds/packages/sound/shairport-sync/Makefile
sed -i 's|$(INSTALL_BIN) ./files/shairport-sync.init $(1)/etc/init.d/shairport-sync|#$(INSTALL_BIN) ./files/shairport-sync.init $(1)/etc/init.d/shairport-sync|' feeds/packages/sound/shairport-sync/Makefile
sed -i 's|$(INSTALL_DIR) $(1)/etc/config|#$(INSTALL_DIR) $(1)/etc/config|' feeds/packages/sound/shairport-sync/Makefile
sed -i 's|$(INSTALL_CONF) ./files/shairport-sync.config $(1)/etc/config/shairport-sync|#$(INSTALL_CONF) ./files/shairport-sync.config $(1)/etc/config/shairport-sync|' feeds/packages/sound/shairport-sync/Makefile


rm -rf feeds/luci/applications/luci-app-dawn
git_sparse_clone master "https://github.com/coolsnowwolf/luci" "feeds/luci/applications/dawn_luci" applications/luci-app-dawn

rm -rf feeds/luci/themes/luci-theme-argon
git clone -b master --depth 1 https://github.com/jerrykuku/luci-theme-argon feeds/luci/themes/luci-theme-argon

rm -rf feeds/luci/applications/*/.git
rm -rf feeds/luci/applications/*/.gitattributes
rm -rf feeds/luci/applications/*/.svn
rm -rf feeds/luci/applications/*/.github
rm -rf feeds/luci/applications/*/.gitignore

sed -i 's|entry({ "admin", "dawn" }, firstchild(), "DAWN", 60)|entry({ "admin", "dawn" }, firstchild(), "Configure DAWN", 60)|g' feeds/luci/applications/luci-app-dawn/luasrc/controller/dawn.lua
sed -i 's|Map("dawn", "Network Overview", translate("Network Overview"))|Map("dawn", translate("Network Overview"), translate("View Network Overview"))|' feeds/luci/applications/luci-app-dawn/luasrc/model/cbi/dawn/dawn_network.lua
sed -i 's|Map("dawn", "Hearing Map", translate("Hearing Map"))|Map("dawn", translate("Hearing Map"), translate("View Hearing Map"))|' feeds/luci/applications/luci-app-dawn/luasrc/model/cbi/dawn/dawn_hearing_map.lua

sed -i 's|s:tab("limit", "Limit Rate by IP Address")|s:tab("limit", translate("Limit Rate by IP Address"))|' feeds/luci/applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua
sed -i 's|s:tab("limitmac", "Limit Rate by Mac Address")|s:tab("limitmac", translate("Limit Rate by Mac Address"))|' feeds/luci/applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua
sed -i 's|s:tab("priority", "Traffic Priority")|s:tab("priority", translate("Traffic Priority"))|' feeds/luci/applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua
echo -e '\n#: applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua:33' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e 'msgid "Limit Rate by IP Address"' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e 'msgstr "通过IP地址限速"' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e '\n#: applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua:34' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e 'msgid "Limit Rate by Mac Address"' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e 'msgstr "通过MAC地址限速"' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e '\n#: applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua:35' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e 'msgid "Traffic Priority"' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e 'msgstr "流量优先级"' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hans/nft-qos.po
echo -e '\n#: applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua:33' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po
echo -e 'msgid "Limit Rate by IP Address"' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po
echo -e 'msgstr "通過IP位址限速"' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po
echo -e '\n#: applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua:34' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po
echo -e 'msgid "Limit Rate by Mac Address"' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po
echo -e 'msgstr "通過MAC位址限速"' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po
echo -e '\n#: applications/luci-app-nft-qos/luasrc/model/cbi/nft-qos/nft-qos.lua:35' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po
echo -e 'msgid "Traffic Priority"' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po
echo -e 'msgstr "流量優先權"' >>feeds/luci/applications/luci-app-nft-qos/po/zh_Hant/nft-qos.po

mkdir -p feeds/luci/modules/luci-base/patches
cp $GITHUB_WORKSPACE/$OP_MANUFACTURER/devices/common/patches/luci-base/* feeds/luci/modules/luci-base/patches


rm -rf feeds/other/luci-app-adguardhome
git_sparse_clone main "https://github.com/kenzok8/small-package" "feeds/other/adguardhome_luci" luci-app-adguardhome

rm -rf feeds/other/lean/luci-app-autoreboot
git_sparse_clone 22.03 "https://github.com/x-wrt/com.x-wrt" "feeds/other/lean/autoreboot_luci" luci-app-autoreboot

rm -rf feeds/luci/applications/luci-app-frpc
rm -rf feeds/luci/applications/luci-app-frps
rm -rf feeds/other/lean/luci-app-frpc
rm -rf feeds/other/lean/luci-app-frps
git_sparse_clone master "https://github.com/kiddin9/openwrt-packages" "feeds/luci/applications/frpc_luci" luci-app-frpc
git_sparse_clone master "https://github.com/kiddin9/openwrt-packages" "feeds/luci/applications/frps_luci" luci-app-frps


chmod +x $GITHUB_WORKSPACE/$OP_MANUFACTURER/devices/common/convert_translation.sh
bash $GITHUB_WORKSPACE/$OP_MANUFACTURER/devices/common/convert_translation.sh -a >/dev/null 2>&1

exit 0