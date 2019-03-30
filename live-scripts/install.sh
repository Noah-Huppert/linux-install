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
#	Does not play nice if run multiple times in a row. Will erase any 
#	existing Linux installations.
#
#?

# {{{1 Exit on any error
set -e

# {{{1 Configuration
prog_dir=$(realpath $(dirname "$0")) 

# {{{1 Helpers
function die() {
	echo "Error: $@" >&2
	exit 1
}

# {{{1 Options
# {{{2 Get
while getopts "c:b:" opt; do
	case "$opt" in
		c) container="$OPTARG" ;;
		b) boot_partition="$OPTARG" ;;
		'?')
			die "Unknown option \"$opt\""
			;;
	esac
done

# {{{2 Verify
# {{{3 CONTAINER_NAME
if [ -z "$container" ]; then
	die "-c CONTAINER_NAME option required"
fi

if [ ! -e "/dev/mapper/$container" ]; then
	die "-c CONTAINER_NAME does not exist in /dev/mapper"
fi

# {{{3 BOOT_PARTITION
if [ -z "$boot_partition" ]; then
	die "-b BOOT_PARTITION option required"
fi

if [ ! -e "$boot_partition" ]; then
	die "-b BOOT_PARTITION does not exist"
fi

# {{{1 Mount devices in preparation for setup
echo "####################"
echo "# Mounting devices #"
echo "####################"

function mount_cleanup() {
	# Unmount in reverse order
	mnts=("/mnt/dev" "/mnt/proc" "/mnt/sys" "/mnt/run" "/mnt/boot/efi" "/mnt")
	if ! umount -R /mnt; then
		die "Failed to umount /mnt. Unmount ${mnts[@]} manually"
	fi
}

trap mount_cleanup EXIT

# {{{2 Root file system
if ! mount "/dev/mapper/$container" /mnt; then
	die "Failed to mount /dev/mapper/$container in /mnt"
fi

# {{{2 Boot partition
if ! mkdir -p /mnt/boot/efi; then
	die "Failed to make mount point /mnt/boot/efi"
fi

if ! mount "$boot_partition" /mnt/boot/efi; then
	die "Failed to mount $boot_partition in /mnt/boot/efi"
fi

# {{{2 Mount system directories
for dir in dev proc sys run; do
	# {{{3 Create mount point
	if ! mkdir -p "/mnt/$dir"; then
		die "Failed to create mount point /mnt/$dir"
	fi

	# {{{3 Create recursive bind mount
	if ! mount --rbind "/$dir" "/mnt/$dir"; then
		die "Failed to create a recursive bind mount for /$dir in /mnt/$dir"
	fi
done

# {{{1 Perform Void Linux installation
echo "#########################"
echo "# Installing Void Linux #"
echo "#########################"

# {{{2 Copy repository signing keys
# {{{3 Configuration files
if ! mkdir -p /mnt/usr/share; then
	die "Failed to create /mnt/usr/share directory"
fi

if ! cp -a /usr/share/xbps.d /mnt/usr/share/; then
	die "Failed to copy XBPS configuration files to new system"
fi

# {{{3 Keys
if ! mkdir -p /mnt/var/db/xbps/keys; then
	die "Failed to create XBPS keys directory"
fi

if ! cp /var/db/xbps/keys/*.plist /mnt/var/db/xbps/keys; then
	die "Failed to copy XBPS keys"
fi

# {{{2 Install packages
if ! xbps-install -Sy \
	-R http://mirror.clarkson.edu/voidlinux/current \
	-r /mnt \
	base-system lvm2 salt; then

	die "Failed to install Void Linux"
	mount_cleanup
fi

if ! sync; then
	die "Failed to sync file system"
fi

# {{{1 Run setup
echo "#######################################"
echo "# Running Setup Script In /mnt Chroot #"
echo "#######################################"

chroot_setup_script_path="/tmp/setup.sh"
mnt_setup_script_path="/mnt$chroot_setup_script_path"

if ! cp "$prog_dir/setup.sh" "$mnt_setup_script_path"; then
	die "Failed to copy setup script to mount directory"
fi

if ! xbps-uchroot /mnt "$chroot_setup_script_path"; then
	die "Failed to run setup script"
fi

if ! rm "$mnt_setup_script_path"; then
	die "Failed to remove copy of setup script in mount directory"
fi

# {{{1 Cleanup
echo "###########"
echo "# Cleanup #"
echo "###########"

# {{{2 Close cryptsetup container
if ! cryptsetup close "$container"; then
	die "Failed to close DM-Crypt LUKS container \"$container\". Run \"cryptsetup close $container\""
fi

# {{{1 Done
echo "########"
echo "# Done #"
echo "########"
