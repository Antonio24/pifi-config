#!/bin/bash

dir=`pwd`

confs=(etc/default/openvpn \
	   etc/hostapd/hostapd.conf \
	   etc/network/interfaces \
	   etc/openvpn/update-resolv-conf \
	   etc/wpa_supplicant/wpa_supplicant.conf \
	   etc/iptables.ipv4.nat \
	   etc/sysctl.conf \
	   etc/init.d/openvpn \
	   etc/dnsmasq.conf \
	   etc/dnsmasq-resolv.conf \
	   etc/resolvconf.conf)

#scp user@192.168.1.200:/etc/default/openvpn
#root='user@192.168.1.200:'
#root='/'
function pull() {
	root=$1
	passwd=$2
	for c in ${confs[@]}
	do
		base=`dirname $c`
		if [[ $root == *"@"* ]]
		mkdir -p $dir/config/$base
		then
			sshpass -p $passwd rsync --progress $root/$c $dir/config/$base
		else
			cp $root/$c $dir/config/$base
		fi
	done
}

function push() {
	root=$1
	passwd=$2
	for c in ${confs[@]}
	do
		base=`dirname /$c`
		if [[ $root == *"@"* ]]
		then
			sshpass -p $passwd rsync --progress $dir/config/$c $root/$base
		else
			cp $dir/config/$c $root/$base
		fi
	done
}

if [[ $1 == 'pull' ]]; then
	pull pi@192.168.1.200: 'raspberry'
elif [[ $1 == 'push' ]]; then
	push root@192.168.1.200: 'raspberrypi'
else
	echo "useage:{pull|push}"
fi
