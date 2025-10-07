#!/usr/bin/env bash

set -xo pipefail

export ALLOW_MISSING_DEPENDENCIES=true

# sync
mkdir build
cd build
git config --global color.ui auto
repo init -u https://github.com/PitchBlackRecoveryProject/manifest_pb -b android-12.1
repo sync
git clone https://github.com/PitchBlackRecoveryProject/android_device_nothing_Pong-pbrp -b android-12.1 device/nothing/Pong

# extract dtb
curl -LO https://mirrorbits.lineageos.org/full/Pong/20251001/vendor_boot.img
python system/tools/mkbootimg/unpack_bootimg.py --boot_img=vendor_boot.img --out=vendor_boot_unpacked
mkdir device/nothing/Pong/prebuilt/dtbs
cp vendor_boot_unpacked/dtb device/nothing/Pong/prebuilt/dtbs/pong.dtb
grep BOARD_INCLUDE_DTB_IN_BOOTIMG device/nothing/Pong/BoardConfigCommon.mk || \
   cat ../../BoardConfigAppend.mk >> device/nothing/Pong/BoardConfigCommon.mk

# build
source build/envsetup.sh
lunch pb_Pong-eng
mka vendorbootimage

cp out/target/product/Pong/vendor_boot.img $GITHUB_WORKSPACE/twrp-nothing-pong.img
