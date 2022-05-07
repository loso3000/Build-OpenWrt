#!/bin/bash

# Modify default IP
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.31.1/g' package/feeds/luci/luci-mod-system/htdocs/luci-static/resources/view/system/flash.js