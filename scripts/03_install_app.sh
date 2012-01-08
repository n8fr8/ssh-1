#!/bin/sh
# clean_app.sh
#
# **Assumes you've manually flashed CM to device through recovery after 01_push.sh**
# (1) Removes some CM bloat apps and files
# (2) Installs a number of APKs for GP apps - pick and choose based on client
# (3) Pushes some standardized ADW settings for launcher config
# (4) Clears cache to remove leftover scraps of removed APKs
#

# check for devices
# wait for device
adb wait-for-device
adb devices|grep -w devices > /dev/null
if [ $? -eq 1 ]; then
	echo "Error: device not found by adb"
	exit 1
fi
echo "Device found"
sleep 1

# install APKs
for f in apps/*
do
 echo "installing $f"
 adb install $f
 sleep 1
done

# push ADW settings & wallpaper
# NOTE: you'll need to manually restore through ADW settings menu once pushed
echo "...pushing adw settings"
adb push settings/adw_settings.xml /sdcard/
sleep 1
adb push settings/adw_launcher.db /sdcard/
sleep 1
echo "...pushing wallpaper"
adb push media/bgtitanium_access.png /sdcard/

adb remount
adb push media/bootanimation.zip /system/media/bootanimation.zip

# reboot to bootloader and clear cache
echo "...rebooting into bootloader"
adb reboot-bootloader
bin/fastboot erase cache
bin/fastboot reboot
adb wait-for-device
