#!/usr/bin/env bash

set -xo pipefail

export ALLOW_MISSING_DEPENDENCIES=true

# sync
git config --global color.ui auto
git clone https://github.com/OrangeFox-mirror/sync
cd sync
bash orangefox_sync.sh --branch 12.1 --path $(pwd)/fox_12.1
cd fox_12.1
git clone https://gitlab.com/OrangeFox/device/Pong -b fox_12.1 device/nothing/Pong

# extract dtb
curl -LO https://mirrorbits.lineageos.org/full/Pong/20251001/vendor_boot.img
python system/tools/mkbootimg/unpack_bootimg.py --boot_img=vendor_boot.img --out=vendor_boot_unpacked
mkdir device/nothing/Pong/prebuilt/dtbs
cp vendor_boot_unpacked/dtb device/nothing/Pong/prebuilt/dtbs/pong.dtb
grep BOARD_INCLUDE_DTB_IN_BOOTIMG device/nothing/Pong/BoardConfigCommon.mk || \
   cat ../../BoardConfigAppend.mk >> device/nothing/Pong/BoardConfigCommon.mk

# build
source build/envsetup.sh
lunch twrp_Pong-eng
mka vendorbootimage
