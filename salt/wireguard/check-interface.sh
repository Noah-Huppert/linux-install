#!/usr/bin/env bash
#?
# check-interface.sh - Check if Wireguard interface is up or down
#
# USAGE
#
#    check-interface.sh OPTIONS
#
# OPTIONS
#
#    -i IFACE       Wireguard interface
#    -u UP_TXT      Text to display if interface is up
#    -d DOWN_TXT    Text to display if interface is down
#
# BEHAVIOR
#
#    Display up or down text depending on state of interface.
#
#?

# {{{1 Helpers
function die() {
    echo "Error: $@" >&2
    exit 1
}

# {{{1 Options
# {{{2 Get
while getopts "i:u:d:" opt; do
    case "$opt" in
	i) interface="$OPTARG" ;;
	u) up_txt="$OPTARG" ;;
	d) down_txt="$OPTARG" ;;
	'?') die "Unknown option" ;;
    esac
done

# {{{2 Verify
# {{{3 Interface
if [ -z "$interface" ]; then
    die "-i IFACE option required"
fi

# {{{3 up_txt
if [ -z "$up_txt" ]; then
    die "-u UP_TXT option required"
fi

# {{{3 down_txt
if [ -z "$interface" ]; then
    die "-d DOWN_TXT option required"
fi


# {{{1 Check interface
status=$(ip link show "$interface")
if [[ "$?" != "0" ]]; then
    die "Failed to get interface \"$interface\" status"
fi

if echo "$status" | grep 'state UP' &> /dev/null; then
    echo "$up_txt"
else
    echo "$down_txt"
fi
