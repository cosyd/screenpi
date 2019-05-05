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
