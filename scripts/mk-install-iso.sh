#!/usr/bin/env bash
#?
# mkiso.sh - Creates a Void Linux MUSL live device
#
# USAGE
#	mkiso.sh DEVICE
#
# ARGUMENTS
#	DEVICE    Device to write live image to
#
# ENVIRONMENT VARIABLE CONFIGURATION
#	TMP_DIR    Directory temporary files will be downloaded to
#?

set -e

# {{{ Env var config
if [ -z "$TMP_DIR" ]; then
	TMP_DIR="/var/tmp"
fi

# {{{ Install xbps
echo "###################"
echo "# Installing XBPS #"
echo "###################"

if ! which xbps-install &> /dev/null; then
	# Download
	xbps_tar_path="$TMP_DIR/xbps.tar.xz"
	if [ ! -f "$xbps_tar_path" ]; then
		if ! curl -L "http://mirror.clarkson.edu/voidlinux/static/xbps-static-latest.x86_64-musl.tar.xz" > "$xbps_tar_path"; then
			echo "Error: Failed to download XBPS" >&2
			exit 1
		fi
	else
		echo "Already downloaded"
	fi

	# Extract
	xbps_dir_path="$TMP_DIR/xbps"
	if [ ! -d "$xbps_dir_path" ]; then
		mkdir "$xbps_dir_path"
		if ! tar -xf "$xbps_tar_path" --directory "$xbps_dir_path"; then
			echo "Error: Failed to extract XBPS" >&2
			rm -rf "$xbps_dir_path"
			exit 1
		fi
	else
		echo "Already extracted"
	fi

	PATH="$PATH:$xbps_dir_path/usr/bin"
else
	echo "Already installed"
fi
# }

# {{{ Check for required software
for prog in curl tar unzip make xz git patch; do
	if ! which "$prog" &> /dev/null; then
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

# { Install void-linux/void-mklive
echo "#####################################"
echo "# Installing void-linux/void-mklive #"
echo "#####################################"

# Download 
void_mklive_dir_path="$TMP_DIR/void_mklive"
if [ ! -d "$void_mklive_dir_path" ]; then
	if ! git clone "https://github.com/void-linux/void-mklive.git" "$void_mklive_dir_path"; then
		echo "Error: Failed to download void-linux/void-mklive" >&2
		exit 1
	fi
fi

# Patch
original_wrkdir="$PWD"
cd "$void_mklive_dir_path"

patches_dir=$(dirname "$0")/../patches
mklive_patch_files=$(ls "$patches_dir"/void-mklive/*.patch)

if [[ "$?" != "0" ]]; then
	echo "Error: Failed to find void-mklive patch files" >&2
	exit 1
fi

for pfile in $mklive_patch_files; do
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
done

cd "$original_wrkdir"

# Build
void_mklive_sh_path="$void_mklive_dir_path/mklive.sh"
if [ ! -f "$void_mklive_sh_path" ]; then
	if ! make -C "$void_mklive_dir_path"; then
		echo "Error: Failed to build void-linux/void-mklive" >&2
		exit 1
	fi
else
	echo "Already built"
fi
# }

# { Make Void ISO
echo "###################"
echo "# Making Void ISO #"
echo "###################"

iso_out_path="$TMP_DIR/void-linux.iso"
if [ ! -f "$iso_out_path" ]; then
	echo "Running $void_mklive_sh_path as sudo, you may prompt for your sudo password"

	if ! cd "$void_mklive_dir_path"; then
		echo "Error: Failed to change to void-linux/void-mklive directory" >&2
		exit 1
	fi

	if [[ "$EUID" != "0" ]]; then
		mklive_run_args="sudo"
	fi

	if ! $mklive_run_args \
		"$void_mklive_sh_path" \
		-o "$iso_out_path" \
		-a "x86_64-musl"; then
		echo "Error: Failed to build Void Linux ISO" >&2
		exit 1
	fi
else
	echo "Already made"
fi

#}
