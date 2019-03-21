#!/usr/bin/env bash
#?
# eduroam.sh - Configures a connection to eduroam
#
# USAGE
#
# 	eduroam.sh OPTIONS
#
# OPTIONS
#
#	-u USERNAME    Eduroam username including `@school.edu`
#	-p PASSWORD    Password
#	-c WPA_CONF    WPA Supplicant configuration file
#	-h             Show help text
#
# BEHAVIOR
#
#	Configures wpa_supplicant to connect to eduroam.#
#
#?

# {{{1 Configuration
ssid="eduroam"
default_wpa_config="/etc/wpa_supplicant/wpa_supplicant.conf"

# {{{1 Helpers
function die() {
	echo "Error: $@" >&2
	exit 1
}

# {{{1 Options
# {{{2 Get
while getopts "u:p:c:h" opt; do
	case "$opt" in 
		u) user="$OPTARG"  ;;
		p) password="$OPTARG"  ;;
		c) wpa_config="$OPTARG"  ;;
		h)
			echo "$0 -u USERNAME -p PASSWORD [-c WPA_CONF -h]"
			exit 1
			;;
		'?')
			die "Unknown option \"$opt\""
			;;
	esac
done

# {{{2 Verify
# {{{3 user
if [ -z "$user" ]; then
	die "-u USER option required"
fi

if [[ ! "$user" =~ .*@.* ]]; then
	die "-u USER option must be in format user@host.tld"
fi

# {{{3 password
if [ -z "$password" ]; then
	die "-p PASSWORD option required"
fi

# {{{3 wpa_config
if [ -z "$wpa_config" ]; then
	wpa_config="$default_wpa_config"
fi

if [ ! -f "$wpa_config" ]; then
	die "-w WPA_CONF configuration file does not exist: $wpa_config"
fi

# {{{1 Check if already configured
if cat "$wpa_config" | grep "ssid=\"$ssid\"" &> /dev/null; then
	die "Entry for $ssid already in $wpa_config"
fi

# {{{1 Write configuration
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

if ! sv restart dhcpcd; then
	die "Failed to restart dhcpcd service"
fi

echo "DONE"
