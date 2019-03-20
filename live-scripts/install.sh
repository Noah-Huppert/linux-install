#!/usr/bin/env bash
#?
# install.sh - Install Void Linux
#
# USAGE
#
#	install.sh OPTIONS
#
# OPTIONS
#
#	-c CONTAINER_NAME    Name of DM-Crypt LUKS container to use as the root 
#	                     file system
#	-b BOOT_PARTITION    Boot partition
#
# BEHAVIOR
#
#	Expects to be run directly after the cryptsetup.sh script. This script
#	leaves CONTAINER_NAME open and accessible 
#	in /dev/mapper/CONTAINER_NAME.
#
#	Installs a plain Void Linux setup in the specified DM-Crypt 
#	LUKS container.
#
#	Then sets up the Refind boot loader in BOOT_PARTITION.
#
#?

# {{{1 Exit on any error
set -e

# {{{1 Options
# {{{2 Get
while getopts "c:b:" opt; do
	case "$opt" in
		c) container="$OPTARG" ;;
		b) boot_partition="$OPTARG" ;;
		'?')
			echo "Error: Unknown option \"$opt\"" >&2
			exit 1
			;;
	esac
done

# {{{2 Verify
# {{{3 CONTAINER_NAME
if [ -z "$container" ]; then
	echo "Error: -c CONTAINER_NAME option required" >&2
	exit 1
fi

if [ ! -e "/dev/mapper/$container" ]; then
	echo "Error: -c CONTAINER_NAME does not exist in /dev/mapper" >&2
	exit 1
fi

# {{{3 BOOT_PARTITION
if [ -z "$boot_partition" ]; then
	echo "Error: -b BOOT_PARTITION option required" >&2
	exit 1
fi

if [ ! -e "$boot_partition" ]; then
	echo "Error: -b BOOT_PARTITION does not exist" >&2
	exit 1
fi

# {{{1 Mount devices in preparation for setup
echo "####################"
echo "# Mounting devices #"
echo "####################"

function mount_cleanup() {
	# Unmount in reverse order
	mnts=("/mnt/dev" "/mnt/proc" "/mnt/sys" "/mnt/run" "/mnt/boot/efi" "/mnt")
	if ! umount -R /mnt; then
		echo "Error: Failed to umount /mnt" >&2
		echo "Ensure ${mnts[@]} are unmounted manually" >&2
		exit 1
	fi
}

# {{{2 Root file system
if ! mount "/dev/mapper/$container" /mnt; then
	echo "Error: Failed to mount /dev/mapper/$container in /mnt" >&2
	mount_cleanup
	exit 1
fi

# {{{2 Boot partition
if ! mkdir -p /mnt/boot/efi; then
	echo "Error: Failed to make mount point /mnt/boot/efi" >&2
	mount_cleanup
	exit 1
fi

if ! mount "$boot_partition" /mnt/boot/efi; then
	echo "Error: Failed to mount $boot_partition in /mnt/boot/efi" >&2
	mount_cleanup
	exit 1
fi

# {{{2 Mount system directories
for dir in dev proc sys run; do
	# {{{3 Create mount point
	if ! mkdir -p "/mnt/$dir"; then
		echo "Error: Failed to create mount point /mnt/$dir" >&2
		mount_cleanup
		exit 1
	fi

	# {{{3 Create recursive bind mount
	if ! mount --rbind "/$dir" "/mnt/$dir"; then
		echo "Error: Failed to create a recursive bind mount for /$dir in /mnt/$dir" >&2
		mount_cleanup
		exit 1
	fi
done

# {{{1 Perform Void Linux installation
echo "#########################"
echo "# Installing Void Linux #"
echo "#########################"

if ! xbps-install -Sy \
	-R https://alpha.de.repo.voidlinux.org/current/x86_64-repodata \
	-r /mnt \
	base-system lvm2 cryptsetup refind; then

	echo "Error: Failed to install Void Linux" >&2
	mount_cleanup
	exit 1
fi

# TODO: Setup refind

# {{{1 Cleanup
echo "###########"
echo "# Cleanup #"
echo "###########"

# {{{2 Cleanup mounts
mount_cleanup

# {{{2 Close cryptsetup container
if ! cryptsetup close "$container"; then
	echo "Error: Failed to close DM-Crypt LUKS container \"$container\"" >&2
	echo "You will have to manually run \"cryptsetup close $container\"" >&2
	exit 1
fi

# {{{1 Done
echo "########"
echo "# Done #"
echo "########"
