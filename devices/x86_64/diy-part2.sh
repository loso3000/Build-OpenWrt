#!/bin/bash

# Modify default IP
sed -i 's/192.168.15.1/10.11.12.2/g' package/base-files/files/bin/config_generate
