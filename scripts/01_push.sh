#!/bin/sh
# push.sh
#
# (1) Pushes CM & (optionally) gapps to device sdcard
# (2) Unlocks bootloader
# (3) Flashes alternate recovery
#
# check for devices
echo "Looking for device..."
adb wait-for-device
adb devices|grep -w devices > /dev/null
if [ $? -eq 1 ]; then
	echo "Error: device not found by adb"
	exit 1
fi
echo "Device found"
sleep 1

# push CM
echo "...uploading system to sdcard"
adb push firmware/system.zip /sdcard/system.zip

# reboot into bootloader
echo "...rebooting into bootloader"
adb reboot-bootloader

# unlock device
echo "...unlocking bootloader"
bin/fastboot oem unlock

# wait for device and reboot to bootloader
echo "Once your device reboots, please enable USB debugging in Settings->Applications->Developer to continue"
adb wait-for-device

echo "...rebooting into bootloader"
adb reboot-bootloader

# flash clockworkmod recovery
echo "...flashing recovery partition"
bin/fastboot flash recovery firmware/recovery.img

bin/fastboot reboot

adb wait-for-device
echo "...rebooting into recovery"
adb reboot recovery

adb wait-for-device
echo "...flashing system"
bin/fastboot flash system firmware/system.zip

# remove unnecessary files
#adb wait-for-device

exit
