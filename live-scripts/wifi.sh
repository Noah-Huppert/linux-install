#!/usr/bin/env bash
#?
# wifi.sh - Connect to a WiFi network using wpa_supplicant on Void Linux
#
# USAGE
#
#	wifi.sh OPTIONS
#
# OPTIONS
#
# 	-s SSID        Name of WiFi network
# 	-p PASSWORD    Password of WiFi network
#
#?

set -e

# {{{1 Config
wpa_supplicant_config_path="/etc/wpa_supplicant/wpa_supplicant.conf"

# {{{1 Options
# {{{2 Get
while getopts "s:p:" opt; do
	case "$opt" in 
		s)
			ssid="$OPTARG"
			;;

		p)
			password="$OPTARG"
			;;

		'?')
			echo "Error: Unknown option \"$opt\"" >&2
			exit 1
			;;
	esac
done
# {{{2 Verify
# {{{3 ssid
if [ -z "$ssid" ]; then
	echo "Error: -s SSID option required" >&2
	exit 1
fi

# {{{3 password
if [ -z "$password" ]; then
	echo "Error: -p PASSWORD option required" >&2
	exit 1
fi

# {{{1 Make WPA supplicant entry
echo "######################################"
echo "# Adding WPA Supplicant Config Entry #"
echo "######################################"

if cat "$wpa_supplicant_config_path" | grep "ssid=\"$ssid\""; then
	echo "Error: Entry for $ssid already exists in $wpa_supplicant_config_path" >&2
	exit 1
fi

if ! wpa_passphrase "$ssid" "$password" >> "$wpa_supplicant_config_path"; then
	echo "Error: Failed to add entry to WPA supplicant config file" >&2
	exit 1
fi

# {{{1 Restart DHCPCD service
echo "#############################"
echo "# Restarting DHCPCD Service #"
echo "#############################"

if ! sv restart dhcpcd; then
	echo "Error: Failed to restart dhcpcd service" >&2
	exit 1
fi

# Wait for internet
echo "########################"
echo "# Waiting For Internet #"
echo "########################"

for i in $(seq 20); do
	if ! ping -c 1 google.com &> /dev/null; then
		printf "."
		sleep 1
	else
		internet_ok="true"
		break
	fi
done

if [ ! -z "$internet_ok" ]; then
	echo "Connected to $ssid"
else
	echo "Error: Failed to connect to $ssid" >&2
	exit 1
fi
