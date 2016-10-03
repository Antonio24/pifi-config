#!/bin/bash

#on pi
vi /etc/ssh/sshd_config
PermitRootLogin yes
#change to raspberrypi
sudo passwd root
sudo passwd --unlock root
sudo reboot

#fix perl local
sudo locale-gen
sudo dpkg-reconfigure locales

wget https://github.com/jenssegers/RTL8188-hostapd/archive/v1.1.tar.gz
tar -zxvf v1.1.tar.gz
cd RTL8188-hostapd-1.1/hostapd
sudo make
sudo make install

sudo apt-get install dnsmasq
sudo apt-get install wpa_supplicant
sudo apt-get install iptables
sudo apt-get install openvpn

brew install http://git.io/sshpass.rb



