#!/usr/bin/env bash
#?
# cp-to-boot.sh - Copy the repository into the /boot/linux-install directory
#
# USAGE
#
#	cp-to-boot.sh
#
# BEHAVIOR
#
#	Must be run as root.
#
#	Copy the repository into the boot directory so it can be used in other
#	linux installations.
#?

set -e

# Check if root
if [[ "$EUID" != "0" ]]; then
	echo "Error: Script must run as root" >&2
	exit 1
fi

# Copy
repo_dir=$(pwd -P)/$(dirname "$0")/..
boot_dir=/boot/linux-install

if ! cp -r "$repo_dir" "$boot_dir"; then
	echo "Error: Failed to copy $repo_dir to $boot_dir" >&2
	exit 1
fi

echo "Copied $repo_dir to $boot_dir"
