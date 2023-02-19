#!/usr/bin/env bash

# Constants
declare -ri TRUE=0
declare -ri FALSE=1

# Exit codes
# ... Options
declare -ri EXIT_CODE_UNKNOWN_OPTION=20
declare -r EXIT_MSG_UNKNOWN_OPTION="Unknown option"

declare -ri EXIT_CODE_NO_UNIT=21
declare -r EXIT_MSG_NO_UNIT="A Systemd unit must be specified via the -u UNIT option"

declare -ri EXIT_CODE_MUTUALLY_EXCLUSIVE_OPTS=22
declare -r EXIT_MSG_MUTUALLY_EXCLUSIVE_OPTS="The -e, -d, -n, and -x options cannot be provided together (with the exception of -e and -n)"

# ... Operations
declare -ri EXIT_CODE_ENABLE_START=30
declare -r EXIT_MSG_ENABLE_START="Failed to enable and start unit"

declare -ri EXIT_CODE_ENABLE=31
declare -r EXIT_MSG_ENABLE="Failed to enable unit"

declare -ri EXIT_CODE_DISABLE=32
declare -r EXIT_MSG_DISABLE="Failed to disable unit"

declare -ri EXIT_CODE_START=33
declare -r EXIT_MSG_START="Failed to start unit"

declare -ri EXIT_CODE_STOP=34
declare -r EXIT_MSG_STOP="Failed to stop unit"

# Print error msg then exit with code
die() { # (code, msg)
    local -ri code="$1"
    local -r msg="$2"
    
    echo "Error: $msg" >&2
    exit $code
}

# Run command and die if fails
run_check() { # (cmd, code, msg, echo? )
    local -r cmd="$1"
    local -ri code="$2"
    local -r msg="$3"
    local -r echo="$4"

    if [[ -n "$echo" ]]; then
	echo "$cmd"
    fi

    if ! eval "$cmd"; then
	die "$code" "$msg"
    fi
}

# Print help text
show_help() {
    cat <<EOF
salt-systemd-user-service.sh - Helps salt manage systemd user services

USAGE

    salt-systemd-user-service.sh [-h] -u UNIT [-c, -e, -d, -n, -x]

OPTIONS

    -h         Shows this help text
    -u UNIT    Specifies the name of the Systemd unit on which to operate
    -c         Checks if the specified unit is in the state specified by: -e, -d, -n, -x
    -e         Enable the unit
    -d         Disable the unit
    -n         Start the unit
    -x         Stop the unit

BEHAVIOR

    This script will manage Systemd services for the user it is run as.

    The -u option specifies which unit to manage.
    The -e, -d, -n, and -x options indicate what action should taken for the unit.
    If the -c option is provided no actions will be taken, but instead the unit's current state will be checked to see if it matches the state declared by the other action options. If its state matches the script will exit with code 0, otherwise code 1.

    The -e, -d, -n, and -x flags are mutually exlusive with each other. With the exception of the -e and -n which can be provided together (Equivilent to systemctl enable --now).
EOF
}

# Options
declare opt_unit=""
declare opt_check=""
declare opt_enable=""
declare opt_disabled=""
declare opt_start=""
declare opt_stop=""

while getopts "hu:cednx" opt; do
    case "$opt" in
	h)
	    show_help
	    exit 0
	    ;;
	u) opt_unit="$OPTARG" ;;
	c) opt_check="y" ;;
	e) opt_enable="y" ;;
	d) opt_disable="y" ;;
	n) opt_start="y" ;;
	x) opt_stop="y" ;;
	'?') die "$EXIT_CODE_UNKNOWN_OPTION" "$EXIT_MSG_UNKNOWN_OPTION" ;;
    esac
done

if [[ -z "$opt_unit" ]]; then
    die "$EXIT_CODE_NO_UNIT" "$EXIT_MSG_NO_UNIT"
fi

declare -r mutually_exlusive_opts="$opt_enable$opt_disable$opt_stop"
if (( ${#mutually_exlusive_opts} > 1 )); then
    die "$EXIT_CODE_MUTUALLY_EXCLUSIVE_OPTS" "$EXIT_MSG_MUTUALLY_EXCLUSIVE_OPTS"
fi

declare -r mutually_exclusive_n_opts="$opt_disable$opt_stop$opt_start"
if (( ${#mutually_exclusive_n_opts} > 1 )); then
    die "$EXIT_CODE_MUTUALLY_EXCLUSIVE_OPTS" "$EXIT_MSG_MUTUALLY_EXCLUSIVE_OPTS"
fi

# If check
if [[ -n "$opt_check" ]]; then
    if [[ -n "opt_enable" ]]; then
	# Check enabled
	declare enabled=""
	if systemctl is-enabled --user "$opt_unit" &> /dev/null; then
	    enabled="y"
	fi

	if [[ -n "$opt_start" ]]; then
	    # Check running
            if systemctl is-active --user "$opt_unit" &> /dev/null && [[ -n "$enabled" ]]; then
		exit $TRUE
	    else
		exit $FALSE
	    fi
	else
	    if [[ -n "$enabled" ]]; then
		exit $TRUE
	    else
		exit $FALSE
	    fi
	fi
    elif [[ -n "$opt_disable" ]]; then
	# Check disabled
	if systemctl is-enabled --user "$opt_unit" &> /dev/null; then
	    exit $FALSE
	else
	    exit $TRUE
	fi
    elif [[ -n "$opt_start" ]]; then
	# Check running
	if systemctl is-active --user "$opt_unit" &> /dev/null; then
	    exit $TRUE
	else
	    exit $FALSE
	fi
    elif [[ -n "$opt_stop" ]]; then
	# Check stopped
	if systemctl is-active --user "$opt_unit" &> /dev/null; then
	    exit $FALSE
	else
	    exit $TRUE
	fi
    fi
else
    # Perform action
    if [[ -n "$opt_enable" ]]; then
	# Enable
	if [[ -n "$opt_start" ]]; then
	    # And start
	    run_check "systemctl enable --now --user '$opt_unit'" "$EXIT_CODE_ENABLE_START" "$EXIT_MSG_ENABLE_START" "y"
	    echo "Enabled and started '$opt_unit'"
	else
	    run_check "systemctl enable --user '$opt_unit'" "$EXIT_CODE_ENABLE" "$EXIT_MSG_ENABLE" "y"
	    echo "Enabled '$opt_unit'"
	fi
    elif [[ -n "$opt_disable" ]]; then
	# Disable
	run_check "systemctl disable --user '$opt_unit'" "$EXIT_CODE_DISABLE" "$EXIT_MSG_DISABLE" "y"
	echo "Disabled '$opt_unit'"
    elif [[ -n "$opt_start" ]]; then
	# Start
	run_check "systemctl start --user '$opt_unit'" "$EXIT_CODE_START" "$EXIT_MSG_START" "y"
	echo "Started '$opt_unit'"
    elif [[ -n "$opt_stop" ]]; then
	# Stop
	run_check "systemctl stop --user '$opt_unit'" "$EXIT_CODE_STOP" "$EXIT_MSG_STOP" "y"
	echo "Stopped '$opt_unit'"
    fi
fi

