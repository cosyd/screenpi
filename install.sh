#!/bin/bash
#
# Configures a plain raspian stretch lite raspberry as video player that can be activated via API
# 
#

# Prerequisites:
# 1) Install clean raspberry with stretch FULL (remember wpa_supplicant and ssh)
# 2) Update: sudo apt-get update && sudo apt-get upgrade; raspi-config to set GPU memory to 256 (under advanced options); set hostname, timezone, locales

## Get git and omxplayer installed
sudo apt-get install git omxplayer

## Get the LCD drivers installed
cd /tmp
git clone https://github.com/waveshare/LCD-show.git
cd LCD-show
# for Raspian-Stretch-Lite
sudo ./LCD35-show lite 
# for Full Raspbian, choose
# sudo ./LCD35-show

## Get the screenpi API script installed
mkdir /home/pi/screenpi
cd /home/pi/screenpi
git clone https://github.com/dpsimon/screenpi
cp screen-api.* /home/pi/screenpi
sudo mv /boot/config.txt /boot/config.txt.backup
sudo cp config.txt /boot
sudo mv /etc/X11/xorg.conf.d/99-calibration.conf /etc/X11/xorg.conf.d/99-calibration.conf.backup
sudo cp 99-calibration /etc/X11/xorg.conf.d/99-calibration.conf
# still missing: add consoleblank=15 to /boot/cmdline.txt for auto screen blanking when unused
