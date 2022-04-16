#!/bin/bash
sed -i 's|https://github.com/x-wrt/packages.git|https://github.com/zhuxiaole/x-wrt-packages.git|' feeds.conf.default
sed -i 's|https://github.com/x-wrt/luci.git|https://github.com/zhuxiaole/x-wrt-luci.git|' feeds.conf.default
echo 'src-git zhuxiaole https://github.com/zhuxiaole/my-packages-for-x-wrt' >>feeds.conf.default