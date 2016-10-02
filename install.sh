#!/bin/bash

sudo apt-get install isc-dhcp-server

wget https://github.com/jenssegers/RTL8188-hostapd/archive/v1.1.tar.gz
tar -zxvf v1.1.tar.gz
cd RTL8188-hostapd-1.1/hostapd
sudo make
sudo make install

