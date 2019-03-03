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
#	-w WPA_CONF    WPA Supplicant configuration file
#	-h             Show help text
#
# BEHAVIOR
#
#	Configures wpa_supplicant to connect to eduroam.#
#
#?

# {{{1 Configuration
ssid="eduroam"

# {{{1 Options
# {{{2 Get
while getopts "u:p:w:h" opt; do
	case "$opt" in 
		u)
			user="$OPTARG"
			;;

		p)
			password="$OPTARG"
			;;

		w)
			wpa_config="$OPTARG"
			;;

		h)
			echo "$0 -u USERNAME -p PASSWORD [-w WPA_CONF -h]"
			exit 1
			;;

		'?')
			echo "Error: Unknown option \"$opt\"" >&2
			exit 1
			;;
	esac
done

# {{{2 Verify
# {{{3 user
if [ -z "$user" ]; then
	echo "Error: -u USER option required" >&2
	exit 1
fi

if [[ ! "$user" =~ .*@.* ]]; then
	echo "Error: -u USER option must be in format user@host.tld" >&2
	exit 1
fi

# {{{3 password
if [ -z "$password" ]; then
	echo "Error: -p PASSWORD option required" >&2
	exit 1
fi

# {{{3 wpa_config
if [ -z "$wpa_config" ]; then
	wpa_config="/etc/wpa_supplicant/config.conf"
fi

if [ ! -f "$wpa_config" ]; then
	echo "Error: -w WPA_CONF configuration file does not exist: $wpa_config" >&2
	exit 1
fi

# {{{1 Check if already configured
if cat "$wpa_config" | grep "ssid=\"$ssid\"" &> /dev/null; then
	echo "Error: Entry for $ssid already in $wpa_config" >&2
	exit 1
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
	echo "Error: Failed to write configuration to $wpa_config" >&2
	exit 1
fi

if ! sv restart dhcpcd; then
	echo "Error: Failed to restart dhcpcd service" >&2
	exit 1
fi

echo "DONE"
