# Automatically run commands on first start

# Only run once
if [ -z "$ZSH_UNIT_AUTOSTART_RUN" ]; then
    # Start wireguard
    if ! ip link show | grep {{ pillar.wireguard.interface }} &> /dev/null; then
	unit-echo "Starting Wireguard"

	if ! wg-quick up {{ pillar.wireguard.interface }}; then
	    return $(unit-die "Failed to start Wireguard")
	fi
    else
	unit-echo "Wireguard already started"
    fi

    # Set flag so we know we've run
    export ZSH_UNIT_AUTOSTART_RUN="true"
fi
