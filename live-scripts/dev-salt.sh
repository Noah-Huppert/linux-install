#!/usr/bin/env bash

# Show help with -h
while getopts "h" opt; do
    case "$opt" in
	   h)
		  cat <<EOF
dev-salt.sh - Source Salt files from the boot partition.

USAGE

	dev-salt.sh

CONFIGURATION

	The following environment variables can be set to configure the script:

		BOOT_PART_LABEL    Label of boot partition, defaults 
		                   to /dev/sda1

BEHAVIOR

	Replaces files in the /srv/{salt,pillar} directories with files on 
	the boot partition located
	in linux-install/iso-rootfs/srv/{salt,pillar}

	This allows for a quicker development cycle of the tools in 
	this repository.

EOF
		  exit 0
		  ;;
	   '?')
		  echo "Error: Unknown option" >&2
		  exit 0
		  ;;
    esac
done

# Configuration
if [ -z "$BOOT_PART_LABEL" ]; then
	BOOT_PART_LABEL="dev/sda1"
fi

# Remove old directories
if ! rm -rf /srv/{salt,pillar}; then
	echo "Error: Failed to remove old Salt files" >&2
	exit 1
fi

# Create boot partition mount point
boot_mount_point=/boot-mount
if ! mkdir "$boot_mount_point"; then
	echo "Error: Failed to create mount point for boot partition" >&2
	exit 1
fi

# Mount boot partition
if ! mount "$BOOT_PART_LABEL" "$boot_mount_point"; then
	echo "Error: Failed to mount boot partition \"$BOOT_PART_LABEL\"" >&2
	exit 1
fi

# Mount files in boot partition
boot_salt_dir="$boot_mount_point/linux-install/iso-rootfs/srv/salt"
boot_pillar_dir="$boot_mount_point/linux-install/iso-rootfs/srv/pillar"

if [ ! -d "$boot_salt_dir" ]; then
	echo "Error: $boot_salt_dir in boot partition" >&2
	exit 1
fi

if [ ! -d "$boot_pillar_dir" ]; then
	echo "Error: $boot_pillar_dir directory in boot partition" >&2
	exit 1
fi

if ! mount --bind "$boot_salt_dir" /srv/salt; then
	echo "Error: Failed to bind /srv/salt from boot partition" >&2
	exit 1
fi

if ! mount --bind "$boot_pillar_dir" /srv/pillar; then
	echo "Error: Failed to bind /srv/pillar from boot partition" >&2
	exit 1
fi

echo "OK"
