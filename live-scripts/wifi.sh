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
# 	-p PASSWORD    (Optional) Password of WiFi network
#	-h             Show help text
#
#?

# {{{1 Config
wpa_supplicant_config_path="/etc/wpa_supplicant/wpa_supplicant.conf"

# {{{1 Helpers
function die() {
	echo "Error: $@" >&2
	exit 1
}

# {{{1 Options
# {{{2 Get
while getopts "s:p:h" opt; do
	case "$opt" in 
		s) ssid="$OPTARG"  ;;
		p) password="$OPTARG"  ;;
		h)
			echo "$0 -s SSID [-p PASSWORD,-h]"
			exit 1
			;;
		'?')
			die "Unknown option \"$opt\""
			;;
	esac
done
# {{{2 Verify
# {{{3 ssid
if [ -z "$ssid" ]; then
	die "-s SSID option required"
fi

# {{{1 Make WPA supplicant entry
if cat "$wpa_supplicant_config_path" | grep "ssid=\"$ssid\""; then
	die "Entry for $ssid already exists in $wpa_supplicant_config_path"
fi

if [ -n "$password" ]; then
    # {{{2 If password provided
    if ! wpa_passphrase "$ssid" "$password" >> "$wpa_supplicant_config_path"; then
	    die "Failed to add entry to WPA supplicant config file"
    fi
else
    # {{{2 If no password provided
    cat <<EOF >> "$wpa_supplicant_config_path"
network={
	ssid="$ssid"
	key_mgmt=NONE
}
EOF
    if [[ "$?" != "0" ]]; then
	die "Failed to add entry to WPA supplicant config file"
    fi
fi

# {{{1 Enable wpa_supplicant
if ! ln -s /etc/sv/wpa_supplicant /var/service; then
	die "Failed to enable wpa_supplicant service"
fi

# Wait for internet
echo "Waiting for internet"

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
	die "Failed to connect to $ssid"
fi

echo "DONE"
