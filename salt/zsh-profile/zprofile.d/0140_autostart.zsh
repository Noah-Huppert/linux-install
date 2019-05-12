# Automatically run commands on first start

function __wg_start() {
    # Start wireguard
    if ! ip link show | grep {{ pillar.wireguard.interface }} &> /dev/null; then
	unit-echo "Starting Wireguard"

	if ! wg-quick up {{ pillar.wireguard.interface }}; then
	    unit-die "Failed to start Wireguard"
	fi
    else
	unit-echo "Wireguard already started"
    fi
}

# Only run once
if [ -z "$ZSH_UNIT_AUTOSTART_RUN" ]; then   
    # Set flag so we know we've run
    export ZSH_UNIT_AUTOSTART_RUN="true"

    __wg_start &
fi
