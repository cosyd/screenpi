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
to configure your stream and the parameters. To optimally configure the parameters of your omxplayer, check out especially its win, crop and aspect-ratio parameters: https://elinux.org/Omxplayer

## Using the interface

After installing & rebooting the pi, you can switch the screen on and off by calling the API:
```
curl http://screenpi:5000/screen/on
curl http://screenpi:5000/screen/off
curl http://screenpi:5000/screen/timer?duration=120
```

### Integrating it into your home automation

Just call 

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc


This repository holds the sample config files and an installation shell script assuming a plain, freshly installed raspberry.

1) Install clean raspberry (remember wpa_supplicant and ssh files before launching it)
2) Update: sudo apt-get update && sudo apt-get upgrade; raspi-config to set GPU memory to 256 (under advanced options); set hostname, timezone, locales
3) run the install.sh script
