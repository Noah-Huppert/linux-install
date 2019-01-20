#!/usr/bin/env bash
#?
# mkiso.sh - Creates a Void Linux MUSL live device
#
# USAGE
#
#	mkiso.sh DEVICE [--remake-iso]
#
# 	Note: The order options and arguments appear in does not matter
#
# ARGUMENTS
#
#	DEVICE    Device to write live image to
#
# OPTIONS
#
#	--remake-iso    Force script to rebuild the ISO, regardless of 
#	                if the ISO already exists on the file system
#
# ENVIRONMENT VARIABLE CONFIGURATION
#	TMP_DIR    Directory temporary files will be downloaded to
#
# BEHAVIOR
#
# 	Can only be run on Void Linux due to compatibility issues
#	with XBPS tools.
#
# 	The script first installs required programs and libraries. 
#
#	Custom patches from the patches/void-mklive directory are 
#	applied to the void-mklive tool. These patches have not 
#	been merged into the mainline of the tool yet. But will
#	become uncessary when they are merged.
#
#	Uses the void-mklive tool to generate a custom ISO. This 
#	ISO will have resources pre-installed which will be used 
#	to automatically setup a persistent Void Linux installation. 
#
#	The iso-rootfs directory is mounted in the ISO at the root of the 
#	ISO filesystem. 
#
# 	This ISO will be burnt onto the DEVICE specified.
#
#?

# Exit on any error
set -e

# {{{1 Env var config
if [ -z "$TMP_DIR" ]; then
	TMP_DIR="/var/tmp"
fi

# {{{1 Check if running on Void
if ! lsb_release -c | grep 'void' &> /dev/null; then
	echo "$0 can only be run on Void Linux due to compatibility issues with XBPS tools" >&2
	exit 1
fi

# {{{1 Parse arguments
while [ ! -z "$1" ]; do
	case "$1" in
		--remake-iso)
			remake_iso="true"
			shift
			;;

		*)
			device="$1"
			shift
			;;
	esac
done

# {{{1 Check arguments
# Device
if [ -z "$device" ]; then
	echo "Error: DEVICE argument must be provided" >&2
	exit 1
fi

if [ ! -e "$device" ]; then
	echo "Error: Device $device specified by DEVICE argument does not exist" >&2
	exit 1
fi

# {{{1 Check for required software
echo "#############################"
echo "# Checking For Dependencies #"
echo "#############################"

for prog in curl tar unzip make xz git patch; do
	# Check if program is in the path
	if ! which "$prog" &> /dev/null; then
		# Install
		echo "$prog not installed, installing"

		if ! xbps-install -Sy "$prog"; then
			echo "Error: Failed to install $pro" >&2
			exit 1
		fi

		# Special install steps
		case "$prog" in
			git)
				git config --global user.name "root"
				git config --global user.email "foo@bar.com"
				;;
		esac

		# Final check
		if ! which "$prog" &> /dev/null; then
			echo "Error: Installed $prog but was not in PATH" >&2
			exit 1
		fi
	fi
done

# {{{1 Check for required libraries
for lib in liblz4.so.1; do
	# Check if library file exists
	if ! ls /usr/lib | grep "$lib" &> /dev/null; then
		# Determine package to install
		case "$lib" in
			liblz4.so.1)
				pkg_name="liblz4"
				;;
		esac

		# Install
		if ! xbps-install -Sy "$pkg_name"; then
			echo "Error: Failed to install $pkg_name to fullfil $lib" >&2
			exit 1
		fi

		# Final check
		if ! ls /usr/lib | grep "$lib"; then
			echo "Error: Installed $pkg_name to fullful $lib but library was not found" >&2
			exit 1
		fi
	fi
done

# {{{1 Install void-linux/void-mklive
echo "#####################################"
echo "# Installing void-linux/void-mklive #"
echo "#####################################"

# {{{2 Download 
void_mklive_dir_path="$TMP_DIR/void_mklive"

# If not downloaded
if [ ! -d "$void_mklive_dir_path" ]; then
	if ! git clone "https://github.com/void-linux/void-mklive.git" "$void_mklive_dir_path"; then
		echo "Error: Failed to download void-linux/void-mklive" >&2
		exit 1
	fi
fi

# {{{2 Patch
patches_dir=$(pwd -P)/$(dirname "$0")/../patches
mklive_patch_files=$(ls "$patches_dir"/void-mklive/*.patch)

if [[ "$?" != "0" ]]; then
	echo "Error: Failed to find void-mklive patch files" >&2
	exit 1
fi

# {{{3 Run commands in void-mklive directory
original_wrkdir="$PWD"
cd "$void_mklive_dir_path"


for pfile in $mklive_patch_files; do
	# Check if already patched
	patch_applied_flag_path="$void_mklive_dir_path/$(basename $pfile).applied"

	if [ -f "$patch_applied_flag_path" ]; then
		echo "Patch \"$pfile\" already applied"
		continue
	else
		echo "Patch applied flag file not found: $patch_applied_flag_path"
	fi

	# If git patch
	if echo "$pfile" | grep ".git.patch" &> /dev/null; then
		if ! git am < "$pfile"; then
			echo "Error: Failed to apply Git patch \"$pfile\"" >&2
			exit 1
		fi
	elif echo "$pfile" | grep ".patch.patch" &> /dev/null; then # Patch patch
		if ! patch < $pfile; then
			echo "Error: Failed to apply Patch patch \"$pfile\"" >&2
			exit 1
		fi
	else
		echo "Error: No patch program matched for \"$pfile\"" >&2
		exit 1
	fi

	# Mark is patched
	touch "$patch_applied_flag_path"
	echo "Patch \"$pfile\" applied"
done

cd "$original_wrkdir"

# {{{2 Build
void_mklive_sh_path="$void_mklive_dir_path/mklive.sh"

if [ ! -f "$void_mklive_sh_path" ]; then
	if ! make -C "$void_mklive_dir_path"; then
		echo "Error: Failed to build void-linux/void-mklive" >&2
		exit 1
	fi
else
	echo "Already built"
fi

# {{{1 Make Void ISO
echo "###################"
echo "# Making Void ISO #"
echo "###################"

iso_out_file="void-linux.iso"
iso_out_path="$void_mklive_dir_path/$iso_out_file"

# {{{2 If remake iso option set, delete old iso file
if [ -f "$iso_out_path" ] && [ ! -z "$remake_iso" ]; then
	if ! rm "$iso_out_path"; then
		echo "Error: Failed to remote Void ISO so it can be remade" >&2
		exit 1
	fi
fi

# {{{2 If iso doesn't exist, make
if [ ! -f "$iso_out_path" ]; then
	# {{{3 Check running as sudoer
	echo "Running $void_mklive_sh_path as sudo, may prompt for your sudo password"

	if [[ "$EUID" != "0" ]]; then
		mklive_run_args="sudo"
	fi

	# {{{3 Assemble ISO filesystem include dir
	repo_dir=$(pwd -P)/$(dirname "$0")/..
	repo_dir=$(realpath "$repo_dir")

	# {{{4 Setup directory where ISO rootfs will be built
	iso_fs_dir="$TMP_DIR/void-iso-rootfs"
	if ! mkdir "$iso_fs_dir"; then
		echo "Error: Failed to make temporary ISO rootfs build directory" >&2
		exit 1
	fi

	# {{{4 Place salt files in ISO rootfs
	# Resolve path of salt files in repo
	repo_salt_dir="$repo_dir/salt"
	
	# Create salt file dir in ISO rootfs
	isofs_salt_dir="$iso_fs_dir/srv"
	if ! mkdir "$isofs_salt_dir"; then
		echo "Error: Failed to make /srv directory in ISO rootfs" >&2
		exit 1
	fi

	# Link Salt state files in ISO rootfs
	if ! mount --bind "$repo_salt_dir/states" "$isofs_salt_dir/salt"; then
		echo "Error: Failed to symlink /srv/salt to Salt states in ISO rootfs" >&2
		exit 1
	fi

	# Link Salt pillar files in ISO rootfs
	if ! mount --bind "$repo_salt_dir/pillar" "$isofs_salt_dir/pillar"; then
		echo "Error: Failed to symlink /srv/pillar to Salt pillar in ISO rootfs" >&2
		exit 1
	fi

	# {{{4 Place repo in ISO rootfs
	isofs_repo_dir="$isofs_dir/root/linux-install"

	# Create repo dir in ISO rootfs
	if ! mkdir "$isofs_repo_dir"; then
		echo "Error: Failed to make /root/linux-install directory in ISO rootfs" >&2
		exit 1
	fi
	
	if ! mount --bind "$repo_dir" "$isofs_repo_dir"; then
		echo "Error: Failed to symlink /root/linux-install to repo in ISO rootfs" >&2
		exit 1
	fi

	# {{{3 Run commands in void-mklive dir
	original_wrkdir=$(pwd -P)
	cd "$void_mklive_dir_path"

	# {{{3 Make ISO
	if ! $mklive_run_args \
		"$void_mklive_sh_path" \
		-o "$iso_out_file" \
		-p "vim salt" \
		-I "$iso_fs_dir" \
		-a "x86_64-musl"; then
		echo "Error: Failed to build Void Linux ISO" >&2
		exit 1
	fi

	# {{{3 Return to original working directory
	cd "$original_wrkdir"

	# {{{3 Remove ISO rootfs build directory
	if ! rm -rf "$iso_fs_dir"; then
		echo "Error: Failed to remove ISO rootfs build directory" >&2
		exit 1
	fi
else
	echo "Already made"
fi
 
# {{{1 Write ISO to device
echo "#########################"
echo "# Writing ISO to DEVICE #"
echo "#########################"

# {{{2 Confirm device to write ISO
echo "Devices:"
if ! lsblk; then
	echo "Error: Failed to list devices" >&2
	exit 1
fi

echo "Write ISO to $device and wipe contents? [y/N] "
read device_confirm_input

if [[ "$device_confirm_input" != "y" && "$device_confirm_input" != "Y" ]]; then
	echo "Device not confirmed, exiting..." >&2
	exit 1
fi

# {{{2 Write ISO to device
echo "Writing to $device"

if ! dd bs=4M status=progress if="$iso_out_path" of="$device" && sync; then
	echo "Error: Failed to write Void ISO to $device" >&2
	exit 1
fi

echo "Wrote to $device"
