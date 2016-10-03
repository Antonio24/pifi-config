#!/bin/bash

DIR=`pwd`

TOKYO1=$DIR/my_expressvpn_japan_-_tokyo_-_1_udp.ovpn
USA=$DIR/my_expressvpn_usa_-_los_angeles_udp.ovpn
HK=$DIR/my_expressvpn_hong_kong_-_1_udp.ovpn

IP=192.168.11.0
MASK=24

function start_openvpn() {
	ovpn=$1
	sudo openvpn $ovpn
}

#don't forget to manully modify the saved iptables
#up iptables-restore < /etc/iptables.ipv4.nat
function backup_iptables() {
	sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
}

#sudo iptables -L -n -v

#Your config file should have *.conf extension for running as a service.
#Just to make everything clear - *.ovpn extension is designed for autostarting on windows clients.

#table[raw->mangle->nat->filter]
#chain[PREROUTING=>FORWARD=>POSTROUTING]
#chain[PREROUTING=>INPUT=>OUTPUT=>POSTROUTING]

#-t --table
#-s --source
#-d --destination
#-i --in-interface
#-o --out-interface
#-j --jump
#-A --append
#-I --insert

#ACCEPT
#DROP
#REJECT

#SNAT
#DNAT
#MASQUERADE

#192.168.11.0/24
function setup_iptables() {
	#sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
	#sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
	#sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT

	sudo iptables -t nat -A POSTROUTING -s tun0 -o wlan0 -j MASQUERADE
	sudo iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
	sudo iptables -t filter -A FORWARD -i tun0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
	sudo iptables -t filter -A FORWARD -i wlan0 -o tun0 -j ACCEPT

	#bypass
	#sudo iptables -t nat -N BYPASS
	#sudo iptables -t nat -A PREROUTING -s SQUIDIP -p tcp --dport 80 -j ACCEPT
	#sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j BYPASS
	#sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3129
	#sudo iptables -t nat -A POSTROUTING -j MASQUERADE

	#sudo iptables -t nat -A BYPASS -d www.baidu.com -j ACCEPT
	#sudo iptables -t nat -A BYPASS -d www.youku.com -j ACCEPT
}

function start_and_save_dhcp() {
	sudo service isc-dhcp-server start
	sudo update-rc.d isc-dhcp-server enable
}

function start_and_save_hostapd() {
	sudo service hostapd start
	sudo update-rc.d hostapd enable
}

function start_and_save_openvpn() {
	sudo service openvpn start
	sudo update-rc.d openvpn enable
}

function dump_boot_log() {
	cat /var/log/syslog
}

start_openvpn $USA
sleep 10s
setup_iptables
