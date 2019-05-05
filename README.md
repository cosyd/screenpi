# ScreenPi

ScreenPi is a small project to run a video player on a Raspberry Pi, mounted in a wall plug frame using a Waveshare 3.5" LCD Display https://www.waveshare.com/wiki/3.5inch_RPi_LCD_(A)

## Getting Started

These instructions will get you a copy of the project up and running.

### Prerequisites

Install a clean raspberry from scratch by downloading the latest raspian and flashing it to an SD card. It is recommended to use one of the more powerful Raspberries, they cost only little more but have much more reserves in their computing power, e.g the A+ or B+.
The A+ is a very good choice as it is nice and small to fit well behind the socket.

After flashing it but before booting it up, add a wpa_supplicant.conf with your WiFi details and an empty ssh file (to enable telnet on it) before you boot it up.

Upon the first boot, change the root password,  configure it, and upgrade it to the latest and install git:
```
passwd
sudo raspi-config
sudo apt-get update && sudo apt-get upgrade
sudo apt-get git
```
In raspi-config, set the GPU memory to 256 MB to boost up the GPU performance (under advanced options), give it a nice hostname - e.g. 'screenpi' and set your timezone + locales correctly.

If you have never done the above steps before, google around for more details on each step.

### Installing

Now pull this repository with the installation script to the pi:
```
cd /tmp
git clone https://github.com/dpsimon/screenpi.git
```
Now execute the installation script:

```
sudo ./install_screenpi.sh
```
## Configuring the stream

Edit the configuration file 
```
sudo nano /home/pi/screen-api.conf
```
to configure your stream and the parameters. To optimally configure the parameters of your omxplayer, check out especially its win, crop and aspect-ratio parameters: [omxplayer](https://github.com/huceke/omxplayer/)

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
If something does not work with the display, check out this manual for config.txt for more options:
https://www.raspberrypi.org/documentation/configuration/config-txt/video.md  


## Ideas for further improvements

The screen currently just blanks when not used, as this particular Waveshare LCD does not support backlight power-off. There are hardware-tweaks, but if someone finds a simple solution (e.g. cheap LCD with power-off with same dimensions), this would be very interesting.
The omxplayer is currently hard killed with a killall. All other solutions did not work reliably (timing the playtime, handing a process ID to the python script and killing only that process). Again a cleaner solution would be great. 
The API is very barebone and does not feedback nice responses, also its behaviour in the timer mode, sending the response only after the time is up could be improved.

## Contributing

Pull requests welcome. The project has been done in some spare time on the side, please do understand if it takes a while for me to respond.

## Authors

* **Simon R** - *Initial work* - [dpsimon](https://github.com/dpsimon)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
