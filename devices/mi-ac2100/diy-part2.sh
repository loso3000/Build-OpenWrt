#!/bin/bash

# Modify default IP
sed -i 's/192.168.15.1/192.168.31.1/g' package/base-files/files/bin/config_generate
