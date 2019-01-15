#!/usr/bin/ebnv bash
#?
# wifi.sh - Connect to a WiFi network using wpa_supplicant on Void Linux
#
# USAGE
#
#	wifi.sh SSID PASSWORD
#
# ARGUMENTS
#
# 	SSID        Name of WiFi network
# 	PASSWORD    Password of WiFi network
#?

set -e

# Config
wpa_supplicant_config_path="/etc/wpa_supplicant/wpa_supplicant.conf"

# Check arguments
# ... ssid
if [ -z "$1" ]; then
	echo "Error: SSID argument must be provided" >&2
	exit 1
fi
ssid="$1"

# ... password
if [ -z "$2" ]; then
	echo "Error: PASSWORD argument must be provided" >&2
	exit 1
fi
password="$2"

# Make WPA supplicant entry
echo "######################################"
echo "# Adding WPA Supplicant Config Entry #"
echo "######################################"

if ! wpa_supplicant "$ssid" "$password" >> "$wpa_supplicant_config_path"; then
	echo "Error: Failed to add entry to WPA supplicant config file" >&2
	exit 1
fi

# Restart DHCPCD service
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
	else
		internet_ok="true"
		break
	fi
done

if [ ! -z "$internet_ok" ]; then
	echo "Connected to $SSID"
else
	echo "Error: Failed to connect to $SSID" >&2
	exit 1
fi
