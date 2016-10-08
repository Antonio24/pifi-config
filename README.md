# pifi-config

#### raspberry pi + USB wifi adapter + openvpn

#### Draft

#### On Raspberry Pi (Hardware)

	1. If using Pi3

		your hardware is awesome ! no other gadgets needed

	2. If using Pi2 & Pi1

		buy a USB wifi adapter support AP mode (the one supported by hostapd)
		I am using the one metioned here:
		http://raspberrypihq.com/how-to-turn-a-raspberry-pi-into-a-wifi-router/
		
#### On Raspberry Pi (Software)

	1. set different static ip address for both your LAN(eth0) and WiFi(wlan0)

		example:
		if your home network ip address format: 192.168.1.x
		LAN: 192.168.1.200
		WiFi:192.168.11.1

	2. enable ssh access (google it)

	3. enable ssh use root user

		vi /etc/ssh/sshd_config (change: PermitRootLogin yes)

		sudo passwd root
		sudo passwd --unlock root
		sudo reboot

	4. install the hostapd

		wget https://github.com/jenssegers/RTL8188-hostapd/archive/v1.1.tar.gz
		tar -zxvf v1.1.tar.gz
		cd RTL8188-hostapd-1.1/hostapd
		sudo make
		sudo make install

	5. install other software

		sudo apt-get install dnsmasq
		sudo apt-get install wpa_supplicant
		sudo apt-get install iptables
		sudo apt-get install openvpn

	6. if your Pi always warning perl local problem

		sudo locale-gen
		sudo dpkg-reconfigure locales

#### On Host Machine (Software)

	1. install sshpass on host machine

		Mac:
		brew install http://git.io/sshpass.rb

		Linux:
		sudo apt-get install sshpass

	2. test ssh login use 'pi' user and 'root' user

		<open terminal>
		ssh pi@192.168.1.200
		exit
		ssh root@192.168.1.200
		exit
		<write down your passwords on note>

	3. run the config.sh script

		<rasbian and MacOS have rsync installed by default, if your system have none, install it>
		mv config config_backup
		./config.sh pull
		<set all the config files under config folder, please refer to the config_backup folder>
		./config.sh push

	4. install.sh and run.sh scripts not used right now.

#### reference

	http://raspberrypihq.com/how-to-turn-a-raspberry-pi-into-a-wifi-router/
	https://frillip.com/using-your-raspberry-pi-3-as-a-wifi-access-point-with-hostapd/

	