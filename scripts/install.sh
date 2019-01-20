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
#	1. MSG    Message to prompt user with
#
# RETURNS
#
#	Input value
#
# ERRORS
#
#	1    If not all arguments provided
#
function prompt() {
	# {{{1 Check arguments
	# {{{2 msg arg
	if [ -z "$1" ]; then
		echo "Error: prompt() MSG argument is required" >&2
		return 1
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
pillar_cryptsetup_secret_f="$salt_pillars_dir/cryptsetup-secret/init.sls"

# Setup cryptsetup secret
#
# ARGUMENTS
#
# 	1. FILE    File to save secrets in
#
# RETURNS
#
#	Secret file contents
#
# ERRORS
#
#	1    Failed to prompt for input
#
function setup_cryptsetup_secrets() {
	cryptsetup_volume_secret=$(prompt "Volume encryption password")
	if [[ "$?" != "0" ]]; then
		echo "Error: Failed to prompt to volume encryption password" >&2
		return 1
	fi

	echo << EOF
cryptsetup:
	volume_secret: $cryptsetup_volume_secret
EOF
}

for secrets_category in cryptsetup-secret; do
	# If secret file doesn't exist
	secret_dir="$salt_pillars_dir/$secrets_category"
	secret_file="$secret_file/init.sls"

	if [ ! -f "$secret_file" ]; then
		# Get secret values
		case "$secrets_category" in
			cryptsetup-secret)
				secret_file_txt=$(setup_cryptsetup_secrets "$secret_file")
				if [[ "$?" != "0" ]]; then
					echo "Error: Failed to prompt for $secrets_category values" >&2
					exit 1
				fi
				;;
		esac

		# Save secret values
		if ! mkdir -p "$secret_dir"; then
			echo "Error: Failed to create $secrets_category directory" >&2
			exit 1
		fi

		if ! echo "$secrets_file_txt" > "$secret_file"; then
			echo "Error: Failed to save $secrets_category file" >&2
			exit 1
		fi
	else
		echo "$secrets_category pillar already exists"
	fi
done

if [ ! -f "$pillar_cryptsetup_secret_f" ]; then
	# {{{3 Get values
	# Volume secret
	cryptsetup_volume_secret=$(prompt "Volume encryption password")

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
