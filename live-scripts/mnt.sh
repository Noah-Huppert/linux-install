#!/usr/bin/env bash

# Exit on any error
set -e

# Configuration
root_partition="/dev/nvme0n1p5"
boot_partition="/dev/nvme0n1p1"

root_mountpoint="/mnt"
boot_mountpoint="/mnt/boot"

container="cryptroot"
container_mountpoint="/dev/mapper/$container"

# Helpers
function die() {
	echo "Error: $@" >&2
	exit 1
}

# Options
# Get
while getopts "r:b:c:uh" opt; do
	case "$opt" in
		r) root_partition="$OPTARG" ;;
		b) boot_partition="$OPTARG" ;;
		c) container="$OPTARG" ;;
		u) do_unmount="true" ;;
		h)
		    cat <<EOF
mnt.sh - Open Luks container and mount along with boot partition.

USAGE

	mnt.sh OPTIONS

OPTIONS

	-r ROOT_PARTITION    (Optional) Root file system partition, defaults
	                     to /dev/nvme0n1p5.
	-b BOOT_PARTITION    (Optional) Boot partition, defaults 
	                     to /dev/nvme0n1p1.
	-c CONTAINER_NAME    (Optional) Name of Luks container to use 
	                     when opening. Defaults to "cryptroot".
	-u                   Unmount and close Luks container.
	-h                   Show help text.

BEHAVIOR

	Opens a Luks container in ROOT_PARTITION and names it CONTAINER_NAME. 
	Then mounts the container in /mnt and mounts the boot partition 
	at /mnt/boot/efi.

	If the -u option is provided the inverse occurs.

EOF
		    exit 0
		    ;;
		'?') die "Unknown option" ;;
	esac
done

# Verify
# ROOT_PARTITION
if [ -z "$root_partition" ]; then
	die "-p ROOT_PARTITION option required"
fi

if [ ! -e "$root_partition" ]; then
	die "-p ROOT_PARTITION \"$root_partition\" does not exist"
fi

# BOOT_PARTITION
if [ -z "$boot_partition" ]; then
	die "-b BOOT_PARTITION option required"
fi

if [ ! -e "$root_partition" ]; then
	die "-b BOOT_PARTITION does not exist: $boot_partition"
fi

# CONTAINER_NAME
if [ -z "$container" ]; then
	die "-c CONTAINER_NAME option required"
fi

if [ ! -z "$do_unmount" ]; then
	if [ ! -e "$container_mountpoint" ]; then
		die "-c CONTAINER_NAME does not exist, must exist when -u option provided"
	fi
fi

# If do_unmount 
if [ ! -z "$do_unmount" ]; then
	echo "Unmounting"

	if ! umount -R "$root_mountpoint"; then
		die "Failed to recursively unmount $root_mountpoint"
	fi

	if ! cryptsetup close "$container"; then
		die "Failed to close container \"$container\""
	fi
else # Otherwise mount
	if ! cryptsetup open "$root_partition" "$container"; then
		die "Failed to open Luks container in partition \"$partition\""
	fi

	if ! mount "$container_mountpoint" "$root_mountpoint"; then
		die "Failed to mount $container in $root_mountpoint"
	fi

	if ! mkdir -p "$boot_mountpoint"; then
		die "Failed to make $boot_mountpoint directory"
	fi

	if ! mount "$boot_partition" "$boot_mountpoint"; then
		die "Failed to mount boot partition"
	fi
fi
