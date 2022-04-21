#!/bin/bash

# Modify default IP
default_ip='10.11.12.2'
sed -i 's/192.168.15.1/$default_ip/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.15.1/$default_ip/g' package/feeds/luci/modules/luci-mod-system/htdocs/luci-static/resources/view/system/flash.js
