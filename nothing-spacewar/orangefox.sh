#!/usr/bin/env bash

set -xo pipefail

export ALLOW_MISSING_DEPENDENCIES=true

# sync
git config --global color.ui auto
git clone https://gitlab.com/OrangeFox/sync
env --chdir=sync bash orangefox_sync.sh --branch 12.1 --path $(pwd)/build
cd build
git clone --depth=1 https://github.com/gmankab/orangefox_device_nothing_Spacewar device/nothing/Spacewar
git clone --depth=1 https://github.com/LineageOS/android_kernel_nothing_sm7325 kernel/nothing/sm7325
mkdir device/nothing/Spacewar/prebuilt/dtbs

# extract dtb and vendor-ramdisk
curl -LO https://mirrorbits.lineageos.org/full/Spacewar/20251001/vendor_boot.img
python system/tools/mkbootimg/unpack_bootimg.py --boot_img=vendor_boot.img --out=vendor_boot_unpacked
cp vendor_boot_unpacked/vendor_ramdisk device/nothing/Spacewar/prebuilt/vendor-ramdisk
cp vendor_boot_unpacked/dtb device/nothing/Spacewar/prebuilt/dtbs/Spacewar.dtb

# build
source build/envsetup.sh
lunch twrp_Spacewar-eng
mka vendorbootimage

cp out/target/product/Spacewar/OrangeFox-R11.3-Beta-Spacewar.img $GITHUB_WORKSPACE/orangefox-nothing-spacewar.img
