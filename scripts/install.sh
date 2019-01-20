#!/usr/bin/env bash
#?
# install.sh - Install Void Linux
#
# USAGE
#
#	install.sh [--test]
#
# OPTIONS
#
#	--test    Run Salt in test mode
#
# BEHAVIOR
#
# 	Retrieves secret configuration values from the user.
#
#	Then runs a Salt high state which installs Void Linux.
#
#?

# Exit on any error
set -e

# Parse arguments
while [ ! -z "$1" ]; do
	case "$1" in
		--test)
			salt_test="true"
			shift
			;;

		*)
			echo "Error: Invalid argument \"$1\"" >&2
			exit 1
			;;
	esac
done

# Prompt for input, cannot be empty
#
# ARGUMENTS
#
#	1. msg    Message to prompt user with
function prompt() {
	# {{{1 Check arguments
	# {{{2 msg arg
	if [ -z "$1" ]; then
		echo "Error: prompt() msg argument is required" >&2
		exit 1
	fi
	msg="$1"
	shift

	# {{{1 Read input
	input_var=""
	while [ -z "$input_var" ]; do
		printf "$msg: "
		read "input_var"
	done

	echo "$input_var"
}

# {{{1 Load secret configuration pillars
echo "###################################"
echo "# Retrieving Secret Configuration #"
echo "###################################"

salt_pillars_dir=$(pwd -P)/$(dirname "$0")/..
salt_pillars_dir=$(realpath "$salt_pillars_dir")

# {{{2 Cryptsetup secret
pillar_cryptsetup_secret_f="$salt_pillars_dir/cryptsetup-secret.sls"

if [ ! -f "$pillar_cryptsetup_secret_f" ]; then
	# {{{3 Get values
	# Volume secret
	cryptsetup_volume_secret=$(prompt "Volume encryption password")
	if [[ "$?" != "0" ]]; then
		echo "Error: Failed to get volume encryption password" >&2
		exit 1
	fi

	# {{{3 Write values
	dd of="$pillar_cryptsetup_secret_f" << EOF
cryptsetup:
  volume_secret: $cryptsetup_volume_secret
EOF
	if [[ "$?" != "0" ]]; then
		echo "Error: Failed to write to cryptsetup secret pillar file" >&2
		exit 1
	fi
else
	echo "Cryptsetup secrets already present"
fi

# {{{1 Apply Salt highstate
echo "#######################"
echo "# Applying Salt State #"
echo "#######################"

if [ ! -z "$salt_test" ]; then
	salt_post_args="test=true"
fi

if ! salt-call --local state.apply $salt_post_args; then
	echo "Error: Failed to run Salt" >&2
	exit 1
fi
