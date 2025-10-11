### orange fox recovery for nothing phone 1

- releases - https://github.com/pocketblue/recovery/releases
- device tree - [orangefox_device_nothing_Spacewar](https://github.com/gmankab/orangefox_device_nothing_Spacewar)
- building script - [nothing-spacewar/orangefox.sh](nothing-spacewar/orangefox.sh)
- workflow - [.github/workflows/release-nothing-spacewar.yml](.github/workflows/release-nothing-spacewar.yml)

### bugs

- touchscreen not works
- battery status not works

### fuatures

- [hardware gui control](https://wiki.orangefox.tech/en/guides/recovery_no_touch) works
- adb shell works
- userdata decryption works

### flashing orangefox

- download `boot.img` from [lineage os build](https://download.lineageos.org/devices/Spacewar/builds)
- download `orangefox_nothing_spacewar.img` from [releases](https://github.com/pocketblue/recovery/releases)

```shell
fastboot --set-active=a
fastboot flash boot_a boot.img
fastboot flash vendor_boot_a orangefox-nothing-spacewar.img
fastboot reboot recovery
```

### uninstall orangefox and get working lineage os back

- download `boot.img` from [lineage os build](https://download.lineageos.org/devices/Spacewar/builds)
- download `vendor_boot.img` from [lineage os build](https://download.lineageos.org/devices/Spacewar/builds)

```shell
fastboot --set-active=a
fastboot flash boot_a boot.img
fastboot flash vendor_boot_a vendor_boot.img
fastboot reboot
```
