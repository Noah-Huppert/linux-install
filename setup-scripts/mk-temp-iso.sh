#!/usr/bin/env bash
#?
# mk-temp-iso.sh - Create a default Void Linux live USB
#
# USAGE
#
#	mk-temp-iso.sh EXTERNAL_DEVICE
#
# ARGUMENTS
#
#	EXTERNAL_DEVICE    External USB device to write live image
#?

set -e

# Configuration
mirror_url="http://mirror.clarkson.edu/voidlinux"
void_version="20181111"
iso_mirror_url="$mirror_url/live/current/void-live-x86_64-musl-$void_version.iso"

tmp_dir="/var/tmp"

# Check arguments
if [ -z "$1" ]; then
	echo "Error: EXTERNAL_DEVICE argument must be provided" >&2
	exit 1
fi
external_device="$1"

if [ ! -e "$external_device" ]; then
	echo "Error: EXTERNAL_DEVICE \"$external_device\" does not exist" >&2
	exit 1
fi

# Download ISO
echo "###########################"
echo "# Download Void Linux ISO #"
echo "###########################"

iso_path="$tmp_dir/void-live-$void_version.iso"

if [ ! -f "$iso_path" ]; then
	if ! curl -L "$iso_mirror_url" > "$iso_path"; then
		echo "Error: Failed to download Void Linux ISO" >&2
		exit 1
	fi
else
	echo "Already downloaded"
fi

# Write image to device
echo "#######################"
echo "# Write ISO To Device #"
echo "#######################"

# Confirm device
echo "Write live image to $external_device (Will erase everything)? [y/N] "
read confirm_device_input

if [[ "$confirm_device_input" != "y" && "$confirm_device_input" != "Y" ]]; then
	echo "Error: External device not confirmed, exiting..." >&2
	exit 1
fi

# Write to device
echo "Writing live image to $external_device"

if [[ "$EUID" != "0" ]]; then
	echo "Must run write operation as root, you may be prompted for your sudo password"
	dd_args="sudo"
fi

if ! $dd_args dd status=progress if="$iso_path" of="$external_device" bs=4M && sync; then
	echo "Error: Failed to write live image to $external_device" >&2
	exit 1
fi

echo "DONE"
