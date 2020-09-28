#!/usr/bin/env bash
#?
# mk-install-media.sh - Create a default Void Linux live USB
#
# USAGE
#
#	mk-install-media.sh [-h,-r, -a ARCH] -d DEVICE
#
# OPTIONS
#
#    -h           Show this help text.
#	-d DEVICE    Device to write ISO to.
#	-r           Redownload ISO.
#	-a ARCH      (Optional) Architecture of ISO to create, either x86_64 or x86_64-musl,
#	             defaults x86_64.
#
#?

# Exit on any error
die() {
    echo "Error: $@" >&2
    exit 1
}

# Configuration
iso_base_path="https://public.funkyboy.zone/noah/void/"
void_version="20190517"

void_arch_glibc="x86_64"
void_arch_musl="x86_64-musl"

tmp_dir="/var/tmp"

# Options
# Get
while getopts "hd:ra:" opt; do
    case "$opt" in
	   h)
		  cat <<EOF
mk-install-media.sh - Create a default Void Linux live USB

USAGE

    mk-install-media.sh [-h,-r, -a ARCH] -d DEVICE

OPTIONS

      -h           Show this help text.
      -d DEVICE    Device to write ISO to.
      -r           Redownload ISO.
      -a ARCH      (Optional) Architecture of ISO to create, either x86_64 or x86_64-musl,
                   defaults x86_64.
EOF
		  exit 0
	   ;;
	   d) device="$OPTARG" ;;
	   r) redownload="true" ;;
	   a) void_arch="$OPTARG" ;;
	   '?') die "Unknow option" ;;
    esac
done

# Verify
# device
if [ -z "$device" ]; then
    echo "Error: -d DEVICE option required" >&2
    exit 1
fi

if [ ! -e "$device" ]; then
    echo "Error: -d DEVICE does not exist: \"$device\"" >&2
    exit 1
fi

# void_arch
if [ -z "$void_arch" ]; then
    void_arch="$void_arch_glibc"
fi

if [[ "$void_arch" != "$void_arch_glibc" && "$void_arch" != "$void_arch_musl" ]]; then
    echo "Error: Invalid -a ARCH value: \"$void_arch\", valid values: $void_arch_glibc, $void_arch_musl" >&2
    exit 1
fi

# Download ISO
echo "###########################"
echo "# Download Void Linux ISO #"
echo "###########################"

echo "Architecture: $void_arch"

iso_mirror_url="$iso_base_path/void-live-$void_arch-$void_version.iso"
iso_path="$tmp_dir/void-live-$void_arch-$void_version.iso"

# Delete iso if redownload option given
if [ -f "$iso_path" ] && [ ! -z "$redownload" ]; then
    if ! rm "$iso_path"; then
	   echo "Error: Failed to delete iso so it can be redownloaded: $iso_path" >&2
	   exit 1
    fi
fi

# Download ISO if haven't already
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
echo "Write live image to $device (Will erase everything)? [y/N] "
read confirm_device_input

if [[ "$confirm_device_input" != "y" && "$confirm_device_input" != "Y" ]]; then
    echo "Error: External device not confirmed, exiting..." >&2
    exit 1
fi

# Write to device
echo "Writing live image to $device"

if [[ "$EUID" != "0" ]]; then
    echo "Must run write operation as root, you may be prompted for your sudo password"
    dd_args="sudo"
fi

if ! $dd_args dd status=progress if="$iso_path" of="$device" bs=4M && sync; then
    echo "Error: Failed to write live image to $device" >&2
    exit 1
fi

echo "DONE"
