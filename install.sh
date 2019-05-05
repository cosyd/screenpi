#!/bin/bash
#
# Configures a plain raspian stretch raspberry as video player that can be activated via API
# 
#

# Prerequisites:
# 1) Install clean raspberry with stretch FULL (remember wpa_supplicant and ssh)
# 2) Update: sudo apt-get update && sudo apt-get upgrade; raspi-config to set GPU memory to 256 (under advanced options); set hostname, timezone, locales

## Get git and omxplayer and flask installed - usually already there
sudo apt-get -y install git omxplayer
sudo pip install flask

## Get the screenpi API script installed
mkdir /home/pi/screenpi
cd /home/pi/screenpi
git clone https://github.com/dpsimon/screenpi
cp screen-api*.* /home/pi/screenpi

# modify screen config
sudo mv /boot/config.txt /boot/config.txt.backup
sudo cp config.txt /boot
sudo mv /etc/X11/xorg.conf.d/99-calibration.conf /etc/X11/xorg.conf.d/99-calibration.conf.backup
sudo cp 99-calibration /etc/X11/xorg.conf.d/99-calibration.conf

# modify cmdline.txt so it has consoleblank=15 to blank the console after a few secs
sudo mv /boot/cmdline.txt /boot/cmdline.txt.backup
sudo cp cmdline.txt /boot/cmdline.txt

# add call of the script to rc.local
sudo cp /etc/rc.local /etc/rc.local.backup
sudo echo "export FLASK_APP=/home/pi/screen-api/screen-api.py" >> /etc/rc.local
sudo echo "python3 -m flask run --host 0.0.0.0 &" >> /etc/rc.local
