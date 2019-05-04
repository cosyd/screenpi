screenpi is a small project to run a video player on a Raspberry Pi, mounted in a wall plug frame using a Waveshare LCD Display

This repository holds the sample config files and an installation shell script assuming a plain, freshly installed raspberry.

1) Install clean raspberry (remember wpa_supplicant and ssh files before launching it)
2) Update: sudo apt-get update && sudo apt-get upgrade; raspi-config to set GPU memory to 256 (under advanced options); set hostname, timezone, locales
3) run the install.sh script
