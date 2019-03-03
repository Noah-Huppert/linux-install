#!/usr/bin/env bash
#?
# mk-temp-iso.sh - Create a default Void Linux live USB
#
# USAGE
#
#	mk-temp-iso.sh OPTIONS EXTERNAL_DEVICE
#
# OPTIONS
#
#	-d         Redownload ISO
#	-a ARCH    (Optional) Architecture of ISO to create, either x86_64 or x86_64-musl,
#	           defaults x86_64
#
# ARGUMENTS
#
#	EXTERNAL_DEVICE    External USB device to write live image
#?

# {{{1 Exit on any error
set -e

# {{{1 Configuration
mirror_url="https://a-hel-fi.m.voidlinux.org"
void_version="20181111"
void_arch_glibc="x86_64"
void_arch_musl="x86_64-musl"

tmp_dir="/var/tmp"

# {{{1 Options
# {{{2 Get
while getopts "da:" opt; do
	case "$opt" in
		d)
			redownload="true"
			shift
			;;

		a)
			void_arch="$OPTARG"
			shift
			shift
			;;

		'?')
			echo "Error: Uknown option \"$opt\"" >&2
			exit 1
			;;
	esac
done

# {{{2 Verify
if [ -z "$void_arch" ]; then
	void_arch="$void_arch_glibc"
fi

if [[ "$void_arch" != "$void_arch_glibc" && "$void_arch" != "$void_arch_musl" ]]; then
	echo "Error: Invalid -a ARCH value: \"$void_arch\", valid values: $void_arch_glibc, $void_arch_musl" >&2
	exit 1
fi

# {{{1 Get arguments
if [ -z "$1" ]; then
	echo "Error: EXTERNAL_DEVICE argument must be provided" >&2
	exit 1
fi
external_device="$1"

if [ ! -e "$external_device" ]; then
	echo "Error: EXTERNAL_DEVICE \"$external_device\" does not exist" >&2
	exit 1
fi

# {{{1 Download ISO
echo "###########################"
echo "# Download Void Linux ISO #"
echo "###########################"

echo "Architecture: $void_arch"

iso_mirror_url="$mirror_url/live/$void_version/void-live-$void_arch-$void_version.iso"
iso_path="$tmp_dir/void-live-$void_arch-$void_version.iso"

# {{{2 Delete iso if redownload option given
if [ -f "$iso_path" ] && [ ! -z "$redownload" ]; then
	if ! rm "$iso_path"; then
		echo "Error: Failed to delete iso so it can be redownloaded: $iso_path" >&2
		exit 1
	fi
fi

# {{{2 Download ISO if haven't already
if [ ! -f "$iso_path" ]; then
	if ! curl -L "$iso_mirror_url" > "$iso_path"; then
		echo "Error: Failed to download Void Linux ISO" >&2
		exit 1
	fi
else
	echo "Already downloaded"
fi

# {{{1 Write image to device
echo "#######################"
echo "# Write ISO To Device #"
echo "#######################"

# {{{1 Confirm device
echo "Write live image to $external_device (Will erase everything)? [y/N] "
read confirm_device_input

if [[ "$confirm_device_input" != "y" && "$confirm_device_input" != "Y" ]]; then
	echo "Error: External device not confirmed, exiting..." >&2
	exit 1
fi

# {{{1 Write to device
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
