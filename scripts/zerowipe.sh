#!/bin/sh
fastboot erase cache
fastboot erase userdata
fastboot erase system
fastboot erase boot
fastboot flash boot boot.img
fastboot flash userdata userdata.img
fastboot flash system system.img
fastboot reboot
