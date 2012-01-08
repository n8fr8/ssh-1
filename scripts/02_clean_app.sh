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
adb wait-for-device
adb devices|grep -w devices > /dev/null
if [ $? -eq 1 ]; then
	echo "Error: device not found by adb"
	exit 1
fi
echo "Device found"
sleep 1

# wait for device
# remount
echo "...removing crap"
adb remount
adb shell rm /system/app/CMParts.apk
adb shell rm /system/app/CMStats.apk
adb shell rm /system/app/CMUpdateNotify.apk
adb shell rm /system/app/DSPManager.apk
adb shell rm /system/app/Email.apk
adb shell rm /system/app/Protips.apk
adb shell rm /system/app/ThemeChooser.apk
adb shell rm /system/app/Torch.apk
adb shell rm /system/media/bootanimation.zip
