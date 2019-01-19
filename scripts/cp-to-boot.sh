#!/usr/bin/env bash
#?
# cp-to-boot.sh - Copy the repository into the /boot/linux-install directory
#
# USAGE
#
#	cp-to-boot.sh [--reverse]
#
# OPTIONS
#
#	--reverse    Copy repository copy in boot partition to 
#	             current directory
#
# BEHAVIOR
#
#	Must be run as root.
#
#	Copy the repository into the boot directory so it can be used in other
#	linux installations.
#?

# Exit on any error
set -e

# {{{1 Check if root
if [[ "$EUID" != "0" ]]; then
	echo "Error: Script must run as root" >&2
	exit 1
fi

# {{{1 Arguments
while [ ! -z "$1" ]; do
	case "$1" in 
		--reverse)
			reverse="true"
			shift
			;;

		*)
			echo "Error: Invalid argument \"$1\"" >&2
			exit 1
			;;
	esac
done

# {{{1 Copy
# {{{2 Resolve paths
repo_dir=$(pwd -P)/$(dirname "$0")/..
repo_dir=$(realpath "$repo_dir")/

boot_dir=/boot/linux-install/

# {{{2 Determine copy direction
if [ -z "$reverse" ]; then
	# If NOT reversed
	from="$repo_dir"
	to="$boot_dir"
else
	# Reversed
	if [ ! -d "$boot_dir" ]; then
		echo "Error: --reverse option cannot be provided if $boot_dir does not exist" >&2 
		exit 1
	fi

	from="$boot_dir"
	to="$repo_dir"
fi

# {{{2 Actually copy
if ! cp -r "$from" "$to"; then
	echo "Error: Failed to copy $from to $to" >&2
	exit 1
fi

echo "Copied $from to $to"
