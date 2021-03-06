#!/usr/bin/env bash

# Options
# Get
while getopts "p:c:h" opt; do
	case "$opt" in
		p) partition="$OPTARG" ;;
		c) container="$OPTARG" ;;
		h)
		    cat <<EOF
crypsetup.sh - Sets up a DM-Crypt LUKS encrypted partition.

USAGE

	cryptset.sh OPTIONS

OPTIONS

	-p PARTITION         Partition to initialize DM-Crypt LUKS container.
	-c CONTAINER_NAME    Name of DM-Crypt LUKS container to leave
	                     open after script exits.

BEHAVIOR

	Securely erases all data in PARTITION. Then creates a DM-Crypt LUKS 
	container. Finally an ext4 file system is created inside the container.

	If this script exits successfully the container will be opened and 
	accessible under the path: /dev/mapper/CONTAINER_NAME

EOF
		    exit 0
		    ;;
		'?')
		    echo "Error: Unknown option \"$opt\"" >&2
		    exit 1
		    ;;
	esac
done

# Verify
# PARTITION
if [ -z "$partition" ]; then
	echo "Error: -p PARTITION option required" >&2
	exit 1
fi

# CONTAINER_NAME
if [ -z "$container" ]; then
	echo "Error: -c CONTAINER_NAME option required" >&2
	exit 1
fi

# Ensure cryptsetup is installed
echo "#########################"
echo "# Checking dependencies #"
echo "#########################"

if ! which cryptsetup &> /dev/null; then
	echo "Installing cryptsetup"

	if ! xbps-install -Sy cryptsetup; then
		echo "Error: Failed to install cryptsetup" >&2
		exit 1
	fi
else
	echo "Cryptsetup already installed"
fi

# Erase partition
echo "##############################"
echo "# Securely erasing partition #"
echo "##############################"

# Confirm user wishes to erase partition
echo "lsblk:"

if ! lsblk; then
	echo "Error: Failed to list partitions" >&2
	exit 1
fi

echo
echo "Are you sure you want to erase everything on $partition? [y/N]"
read erase_confirm

if [[ "$erase_confirm" != "y" ]]; then
	echo "Failed to confirm erase, exiting..." >&2
	exit 1
fi

# Create temporary container so we can erase
erase_container="container"

function erase_cleanup() {
	# Cleanup erase container if still open
	if [ -e "/dev/mapper/$erase_container" ]; then
		if ! cryptsetup close "$erase_container"; then
			echo "Error: Failed to close temporary cryptsetup container \"$erase_container\" which was used to erase partition \"$partition\"" >&2
			echo "You will have to run \"cryptsetup close $erase_container\" manually before invoking this script again" >&2
			exit 1
		fi
	fi
}
echo "This may take some time (Replacing every bit in partition with a 0)"


if ! cryptsetup open --type plain "$partition" "$erase_container" --key-file /dev/random; then
	echo "Error: Failed to open temporary cryptsetup container for the purpose of securely erasing partition \"$partition\"" >&2
	exit 1
fi

# Erase
# Get size of partition
erase_size_bytes=$(blockdev --getsize64 "$partition")
if [[ "$?" != "0" ]]; then
	echo "Error: Failed to get size of \"$partition\"" >&2
	exit 1
fi

if ! dd \
	if=/dev/zero \
	of="/dev/mapper/$erase_container" \
	status=progress \
	bs=1M \
	count="$erase_size_bytes" \
	iflag=count_bytes; then

	echo "Error: Failed to overwrite partition \"$partition\" zeros" >&2
	erase_cleanup
	exit 1
fi

if ! sync; then
	echo "Error: Failed to sync file system" >&2
	exit 1
fi

# Close temporary container
erase_cleanup

# Create DM-Crypt LUKS container
echo "####################################"
echo "# Creating DM-Crypt LUKS container #"
echo "####################################"

# Create container
if ! cryptsetup -y -v luksFormat "$partition"; then
	echo "Error: Failed to create DM-Crypt LUKS container for partition \"$partition\"" >&2
	exit 1
fi

# Open container
if ! cryptsetup open "$partition" "$container"; then
	echo "Error: Failed to open DM-Crypt LUKS container for partition \"$partition\"" >&2
	exit 1
fi

# Create filesystem in container
if ! mkfs.ext4 "/dev/mapper/$container"; then
	echo "Error: Failed to create an ext4 file system in the DM-Crypt LUKS container for partition \"$partition\"" >&2
	exit 1
fi

# Done
echo "########"
echo "# Done #"
echo "########"

echo "DM-Crypt LUKS container with name \"$container\" accessible as a device under the path: /dev/mapper/$container"

