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


chmod +x $GITHUB_WORKSPACE/$OP_MANUFACTURER/devices/common/convert_translation.sh
bash $GITHUB_WORKSPACE/$OP_MANUFACTURER/devices/common/convert_translation.sh -a >/dev/null 2>&1

exit 0