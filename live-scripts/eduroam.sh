#!/usr/bin/env bash

# Configuration
ssid="eduroam"
default_wpa_config="/etc/wpa_supplicant/wpa_supplicant.conf"

# Helpers
function die() {
	echo "Error: $@" >&2
	exit 1
}

# Options
# Get
while getopts "u:p:c:h" opt; do
	case "$opt" in 
		u) user="$OPTARG"  ;;
		p) password="$OPTARG"  ;;
		c) wpa_config="$OPTARG"  ;;
		h)
		    cat <<EOF
eduroam.sh - Configures a connection to eduroam.

USAGE

	eduroam.sh OPTIONS

OPTIONS

	-u USERNAME    Eduroam username including \`@school.edu\`.
	-p PASSWORD    Password.
	-c WPA_CONF    WPA Supplicant configuration file.
	-h             Show help text.

BEHAVIOR

	Configures wpa_supplicant to connect to eduroam.

EOF
			exit 0
			;;
		'?')
			die "Unknown option \"$opt\""
			;;
	esac
done

# Verify
# user
if [ -z "$user" ]; then
	die "-u USER option required"
fi

if [[ ! "$user" =~ .*@.* ]]; then
	die "-u USER option must be in format user@host.tld"
fi

# password
if [ -z "$password" ]; then
	die "-p PASSWORD option required"
fi

# wpa_config
if [ -z "$wpa_config" ]; then
	wpa_config="$default_wpa_config"
fi

if [ ! -f "$wpa_config" ]; then
	die "-w WPA_CONF configuration file does not exist: $wpa_config"
fi

# Check if already configured
if cat "$wpa_config" | grep "ssid=\"$ssid\"" &> /dev/null; then
	die "Entry for $ssid already in $wpa_config"
fi

# Write configuration
config="network={\n"
config+="        ssid=\"$ssid\"\n"
config+="        key_mgmt=WPA-EAP\n"
config+="        eap=TTLS\n"
config+="        phase2=\"auth=PAP\"\n"
config+="        identity=\"$user\"\n"
config+="        password=\"$password\"\n"
config+="}"

echo "Configuration:"
echo -e "$config"
echo

if ! echo -e "$config" >> "$wpa_config"; then
	die "Failed to write configuration to $wpa_config"
fi

# Enable wpa_supplicant service
if ! ln -s /etc/sv/wpa_supplicant /var/service; then
	die "Failed enable wpa_supplicant service"
fi

# Wait for internet connection
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
