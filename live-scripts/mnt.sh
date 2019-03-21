#!/usr/bin/env bash
#?
# mnt.sh - Open Luks container and mount along with boot partition
#
# USAGE
#
# 	mnt.sh OPTIONS
#
# OPTIONS
#
#	-p ROOT_PARTITION    Root file system partition
#	-b BOOT_PARTITION    Boot partition
#	-c CONTAINER_NAME    (Optional) Name of Luks container to use 
#	                     when opening. Defaults to "cryptroot".
#	-u                   Unmount and close Luks container
#	-h                   Show help text
#
# BEHAVIOR
#
#	Opens a Luks container in ROOT_PARTITION and names it CONTAINER_NAME. 
#	Then mounts the container in /mnt and mounts the boot partition 
#	at /mnt/boot/efi.
#
#	If the -u option is provided the inverse occurs.
#
#?

# {{{1 Exit on any error
set -e

# {{{1 Configuration
default_container="cryptroot"

# {{{1 Helpers
function die() {
	echo "Error: $@" >&2
	exit 1
}

# {{{1 Options
# {{{2 Get
while getopts "p:b:c:uh" opt; do
	case "$opt" in
		p) root_partition="$OPTARG" ;;
		b) boot_partition="$OPTARG" ;;
		c) container="$OPTARG" ;;
		u) do_unmount="true" ;;
		h)
			echo "$0 -p ROOT_PARTITION -b BOOT_PARTITION -c CONTAINER_NAME [-u,-h]"
			exit 1
			;;
		'?')
			echo "Error: Unknown option \"$opt\"" >&2
			exit 1
			;;
	esac
done

# {{{2 Verify
# {{{3 ROOT_PARTITION
if [ -z "$root_partition" ]; then
	die "-p ROOT_PARTITION option required"
fi

if [ ! -e "$root_partition" ]; then
	die "-p ROOT_PARTITION does not exist: $root_partition"
fi

# {{{3 BOOT_PARTITION
if [ -z "$boot_partition" ]; then
	die "-b BOOT_PARTITION option required"
fi

if [ ! -e "$root_partition" ]; then
	die "-b BOOT_PARTITION does not exist: $boot_partition"
fi

# {{{3 CONTAINER_NAME
if [ -z "$container" ]; then
	container="$default_container"
fi

if [ -z "$do_unmount" ]; then
	if [ ! -e "/dev/mapper/$container" ]; then
		die "-c CONTAINER_NAME does not exist, must exist when -u option provided"
	fi
fi

# {{{1 If do_unmount 
if [ ! -z "$do_unmount" ]; then
	echo "Unmounting"

	if ! umount -R /mnt; then
		die "Failed to recursively unmount /mnt"
	fi

	if ! cryptsetup close "$container"; then
		die "Failed to close container \"$container\""
	fi
else # Otherwise mount
	if ! cryptsetup "$root_partition" "$container"; then
		die "Failed to open Luks container in partition \"$partition\""
	fi

	if ! mount "/dev/mapper/$container" /mnt; then
		die "Failed to mount $container in /mnt"
	fi

	if ! mkdir -p /mnt/boot/efi; then
		die "Failed to make /mnt/boot/efi directory"
	fi

	if ! mount "$boot_partition" /mnt/boot/efi; then
		die "Failed to mount boot partition"
	fi
fi
