## Enable remote login from windows when ubuntu is installed on raspberry pi

### [xrdp stuck after inserting password](https://github.com/neutrinolabs/xrdp/issues/1795)

```
sudo systemctl set-default graphical

sudo systemctl isolate graphical
```

### [Install firefox-esr](https://askubuntu.com/questions/1406527/why-doesnt-ubuntu-provide-firefox-esr-in-its-repositories)
Snap firefox doesn't run on raspberry pi. 
```
sudo snap remove firefox

sudo add-apt-repository ppa:mozillateam/ppa

echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

sudo apt install firefox-esr
```

### File management
- Add .xsession and .xsessionrc in the home directory of user
- Copy startwm.sh to /etc/xrdp
  
### Enable auto login for user
```
# sudo nano /etc/gdm3/custom.conf
AutomaticLoginEnable=True
AutomaticLogin=<specify login user id for eg. pi>

```
``` # sudo service xrdp restart```
## Steps to enable auto mount harddisk. 
<i>Rest of the details are optional. </i>

We can use fstab but it creates problem in the startup if harddisk is not connected

### Mount harddisk
- [refer this for different options](https://www.squash.io/executing-bash-script-at-startup-in-ubuntu-linux/)
 ```
For eg. # cat /etc/rc.local

#!/bin/sh -e
/home/pi/script/mountdisk.sh
exit 0
```
## Steps to host local media server

### Haproxy
User haproxy xfg if need to manage raspberry pi at port 80

### Docker compose
- Host jellyfin
- Host plex if needed

Change image path for logo and jellyfin will look like netflix

```
@import url("https://cdn.jsdelivr.net/gh/prayag17/JellyFlix@latest/default.css");
@import url("https://cdn.jsdelivr.net/gh/prayag17/JellyFlix@latest/addons/Logo.css");

.adminDrawerLogo img { 
content: url(<image path>) !important; 
} 
imgLogoIcon { 
content: url(<image path>) !important; 
} 

.pageTitleWithLogo { 
background-image: url(<image path>) !important; 
}
```

### [How to Remove Firefox ESR](https://ubuntuhandbook.org/index.php/2022/03/install-firefox-esr-ubuntu/)

To remove the Firefox package, open terminal (Ctrl+Alt+T) and run command:

```
sudo apt remove --autoremove firefox-esr
```

And run command to remove the Ubuntu PPA:

```
sudo add-apt-repository --remove ppa:mozillateam/ppa
```
### Mount service for hdd

Create service 
```
sudo nano /etc/systemd/system/mount-jellyfin.service
```
#### If mount directory is a volume in docker

Add this
```
[Unit]
After=mount-jellyfin-hdd.service
Requires=mount-jellyfin-hdd.service
```

Now execute theses commands
```
sudo systemctl daemon-reload
sudo systemctl enable mount-jellyfin
sudo systemctl enable docker
```
