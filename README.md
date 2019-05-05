# ScreenPi

ScreenPi is a small project to run a video player on a Raspberry Pi, mounted in a wall plug frame using a Waveshare 3.5" LCD Display.

## Getting Started

These instructions will get you a copy of the project up and running.

### Prerequisites

Install a clean raspberry from scratch by downloading the latest raspian full image and flashing it to an SD card. The LCD driver does not work with lite (event though waveshare claims it does with a special parameter "lite", does not work with current versions). Regarding the hardware, it is recommended to use one of the more powerful Raspberries, they cost only little more but have much more reserves in their computing power, e.g the A+ or B+. The A+ is a very good choice as it is nice and small to fit well behind the socket.

After flashing it but before booting it up, add a wpa_supplicant.conf with your WiFi details and an empty ssh file (to enable telnet on it) before you boot it up.

Upon the first boot, change the root password,  configure it, and upgrade it to the latest and install git:
```
passwd
sudo apt-get -y update && sudo apt-get -y upgrade
sudo raspi-config
```
In raspi-config, set the GPU memory to 256 MB to boost up the GPU performance (under advanced options), give it a nice hostname - e.g. 'screenpi' and set your timezone + locales correctly. Also, set the boot up option to "splash screen" so it looks tidier when it boots up.

If you have never done the above steps before, google around for more details on each step.

Now install the LCD drivers. As this reboots the machine, it is not part of the install.sh script.

```
cd /home/pi
git clone https://github.com/waveshare/LCD-show.git
cd LCD-show
sudo ./LCD35-show 
```
Be careful, the waveshare driver aggresively overwrites some system files. If you do this to a system that is configured in further ways, make backups before running this.

### Installing

Now pull the repository with the sample config files and script to the pi:
```
cd /home/pi
git clone https://github.com/dpsimon/screenpi.git 
```
And configure the URL in the screen-api.py file:

```
sudo nano screen-api.py
```
by modifying the line omx_start="..." parameter to include your video stream URL (and potentially further parameters, see below the manual of omxplayer).

## Configuration

Configure the screen to fit the dimensions of the frame and rotating it by 90°
```
sudo nano /boot/config.txt
```
by setting these values in /boot/config.txt (see also file in the repository)
```
disable_overscan=1
overscan_top=90
overscan_bottom=30
dtoverlay=waveshare35a:rotate=0
start_x=1
gpu_mem=256
hdmi_blanking=1
disable_touchscreen=1

```
and by creating this directory and creating a further config file:
```
sudo mkdir /etc/X11/xorg.conf.d
sudo nano /etc/X11/xorg.conf.d/99-calibration.conf
```
with this content (see also file in repository)
```
Section "InputClass"
        Identifier "calibration"
        MatchProduct "ADS7846 Touchscreen"
# 90 degrees rotated
        Option "Calibration" "219 3835 219 3984 "
        Option "SwapAxes" "0"
#       Option "Calibration" "3853 170 288 3796"
#       Option "SwapAxes" "1"
EndSection
```
to configure your stream and the parameters. To optimally configure the parameters of your omxplayer, check out especially its win, crop and aspect-ratio parameters: [omxplayer](https://github.com/huceke/omxplayer/)

Finally, edit /etc/rc.local 
```
sudo nano /etc/rc.local
```
and append these two lines to the file to have an auto startup upon boot:
```
export FLASK_APP=/home/pi/screenpi/screen-api.py
python3 -m flask run --host 0.0.0.0 &
```

## Using the interface

After installing & rebooting the pi, you can switch the screen on and off by calling the API:
```
curl http://screenpi:5000/screen/on
curl http://screenpi:5000/screen/off
curl http://screenpi:5000/screen/timer?duration=120
```

### Integrating it into your home automation

You can call the API to start up the screen from within your favorite home automation, e.g. in a node.js script 
```
var request     = require('request');  // http requests to set outbound webhooks
request.get("http://screen:5000/screen/timer?duration=300");
```

## Built With

* [omxplayer](https://github.com/huceke/omxplayer/) - Video Player
* [flask](https://github.com/pallets/flask) - API
* [Waveshare LCD](https://github.com/waveshare/LCD-show) - Waveshare LCD driver
**Manual for config.txt for more options: https://www.raspberrypi.org/documentation/configuration/config-txt/video.md  
**WIKI for the LCD: https://www.waveshare.com/wiki/3.5inch_RPi_LCD_(A)

## Ideas for further improvements

The screen currently just blanks when not used, as this particular Waveshare LCD does not support backlight power-off. There are hardware-tweaks, but if someone finds a simple solution (e.g. cheap LCD with power-off with same dimensions), this would be very interesting.
The omxplayer is currently hard killed with a killall. All other solutions did not work reliably (timing the playtime, handing a process ID to the python script and killing only that process). Again a cleaner solution would be great. 
The API is very barebone and does not feedback nice responses, also its behaviour in the timer mode, sending the response only after the time is up could be improved.

## Contributing

Pull requests welcome. The project has been done in some spare time on the side, please do understand if it takes a while for me to respond.

## Authors

* **Simon R** - *Initial work* - [dpsimon](https://github.com/dpsimon)
