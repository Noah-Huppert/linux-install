#!/usr/bin/env bash
#?
# mklive.sh - Creates a Void Linux MUSL live device
#
# USAGE
#	mklive.sh DEVICE
#
# ARGUMENTS
#	DEVICE    Device to write live image to
#
# ENVIRONMENT VARIABLE CONFIGURATION
#	TMP_DIR    Directory temporary files will be downloaded to
#?

# Env var config
if [ -z "$TMP_DIR" ]; then
	TMP_DIR="/var/tmp"
fi

# { Install void-linux/void-mklive
echo "#####################################"
echo "# Installing void-linux/void-mklive #"
echo "#####################################"

# Download
void_mklive_zip_path="$TMP_DIR/void_mklive.zip"
if [ ! -f "$void_mklive_zip_path" ]; then
	if ! curl -L "https://github.com/void-linux/void-mklive/archive/master.zip" > "$void_mklive_zip_path"; then
		echo "Error: Failed to download void-linux/void-mklive" >&2
		exit 1
	fi
fi

# Unzip
void_mklive_dir_path="$TMP_DIR/void_mklive"
if [ ! -d "$void_mklive_dir_path" ]; then
	if ! unzip -d "$void_mklive_dir_path" "$void_mklive_zip_path"; then
		echo "Error: Failed to unzip void-linux/void-mklive" >&2
		exit 1
	fi
fi

void_mklive_dir_path="$void_mklive_dir_path/void-mklive-master"

# Build
void_mklive_sh_path="$void_mklive_dir_path/mklive.sh"
if [ ! -f "$void_mklive_sh_path" ]; then
	if ! make -C "$void_mklive_dir_path"; then
		echo "Error: Failed to build void-linux/void-mklive" >&2
		exit 1
	fi
fi
# }

# { Make Void ISO
echo "###################"
echo "# Making Void ISO #"
echo "###################"


#}
