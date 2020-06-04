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
#    -b BOOT_PARTITION    Boot partition
#    -r ROOT_PARTITION    Root file partition
#	-c                   (Optional) If provided indicates that ROOT_PARTITION is
#                         actually the name of a DM-Crypt LUKS container to use
#                         as the root file system
#    -s SETUP_ARGS        (Optional) Arguments which will be passed to the setup.sh
#                         script. Can be specified multiple times.
#    -g GRAINS_FILE       (Optional) Path to a Salt grains file which will be placed
#                         in the new installation.
#
# BEHAVIOR
#
#	If -c is provided expects to be run directly after the cryptsetup.sh script.
#    This script leaves the DM-Crypt LUKS container named ROOT_PARTITION open and
#    accessible in /dev/mapper/ROOT_PARTITION.
#
#	Installs a plain Void Linux setup in the specified DM-Crypt 
#	LUKS container.
#
#	Does not play nice if run multiple times in a row. Will erase any 
#	existing Linux installations.
#
#?

# Exit on any error
set -e

# Configuration
prog_dir=$(realpath $(dirname "$0")) 

# Helpers
function die() {
	echo "Error: $@" >&2
	exit 1
}

# Options
setup_script_args=()

while getopts "cr:b:s:g:" opt; do
    case "$opt" in
	   c) root_is_container=true ;;
	   r) root_partition="$OPTARG" ;;
	   b) boot_partition="$OPTARG" ;;
	   s) setup_script_args+=("$OPTARG") ;;
	   g) salt_grains_file="$OPTARG" ;;
	   '?')
		  die "Unknown option \"$opt\""
		  ;;
    esac
done

# CONTAINER_NAME
if [ -n "$root_is_container" ]; then
    root_partition="/dev/mapper/$root_partition"
fi

# ROOT_PARTITION
if [ -z "$root_partition" ]; then
    die "-r ROOT_PARTITION option required"
fi

if [ ! -e "$root_partition" ]; then
	die "-r ROOT_PARTITION does not exist"
fi

# BOOT_PARTITION
if [ -z "$boot_partition" ]; then
	die "-b BOOT_PARTITION option required"
fi

if [ ! -e "$boot_partition" ]; then
	die "-b BOOT_PARTITION does not exist"
fi

# GRAINS_FILE
if [ ! -f "$salt_grains_file" ]; then
    die "-g GRAINS_FILE does not exist"
fi

# Mount devices in preparation for setup
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

# Root file system
if ! mount "$root_partition" /mnt; then
	die "Failed to mount $root_partition in /mnt"
fi

# Boot partition
if ! mkdir -p /mnt/boot/efi; then
	die "Failed to make mount point /mnt/boot/efi"
fi

if ! mount "$boot_partition" /mnt/boot/efi; then
	die "Failed to mount $boot_partition in /mnt/boot/efi"
fi

# Mount system directories
for dir in dev proc sys run; do
	# Create mount point
	if ! mkdir -p "/mnt/$dir"; then
		die "Failed to create mount point /mnt/$dir"
	fi

	# Create recursive bind mount
	if ! mount --rbind "/$dir" "/mnt/$dir"; then
		die "Failed to create a recursive bind mount for /$dir in /mnt/$dir"
	fi
done

# Perform Void Linux installation
echo "#########################"
echo "# Installing Void Linux #"
echo "#########################"

# Copy repository signing keys
# Configuration files
if ! mkdir -p /mnt/usr/share; then
	die "Failed to create /mnt/usr/share directory"
fi

if ! cp -a /usr/share/xbps.d /mnt/usr/share/; then
	die "Failed to copy XBPS configuration files to new system"
fi

# Keys
if ! mkdir -p /mnt/var/db/xbps/keys; then
	die "Failed to create XBPS keys directory"
fi

if ! cp /var/db/xbps/keys/*.plist /mnt/var/db/xbps/keys; then
	die "Failed to copy XBPS keys"
fi

# Install packages
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

# Run setup
echo "#######################################"
echo "# Running Setup Script In /mnt Chroot #"
echo "#######################################"

# Copy setup script
chroot_setup_script_path="/tmp/setup.sh"
setup_script_path="/mnt$chroot_setup_script_path"

if ! cp "$prog_dir/setup.sh" "$setup_script_path"; then
	die "Failed to copy setup script to mount directory"
fi

function cleanup_setup_script() {
	if [ -f "$setup_script_path" ]; then
		if ! rm "$setup_script_path"; then
			die "Failed to cleanup setup script"
		fi
	fi
}

trap cleanup_setup_script EXIT

# Copy DNS resolver configuration
chroot_resolve_conf_path="/etc/resolv.conf"
resolve_conf_path="/mnt$chroot_resolve_conf_path"

if ! cp "/etc/resolv.conf" "$resolve_conf_path"; then
	die "Failed to copy DNS configuration to mount directory"
fi

# Copy salt grains file
if [ -n "$salt_grains_file" ]; then
    if ! cp "$salt_grains_file" "/mnt/etc/salt/grains"; then
	   die "Failed to copy Salt grains file \"$salt_grains_file\" into mount directory"
    fi
fi

# Run setup script
if ! xbps-uchroot /mnt "$chroot_setup_script_path ${setup_script_args[@]}"; then
	die "Failed to run setup script"
fi

# Cleanup
echo "###########"
echo "# Cleanup #"
echo "###########"

# Close cryptsetup container
if [ -n "$root_is_container" ]; then
    if ! cryptsetup close "$container"; then
	   die "Failed to close DM-Crypt LUKS container \"$container\". Run \"cryptsetup close $container\""
    fi
fi

# Done
echo "########"
echo "# Done #"
echo "########"
