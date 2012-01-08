#!/bin/sh
echo "preparing to power-up your smartphone..."
mkdir apps
mkdir firmware
scripts/00_get_apps.sh
scripts/01_push.sh
scripts/02_clean_app.sh
scripts/03_install_app.sh
echo "Welcome to the real world, Neo"
