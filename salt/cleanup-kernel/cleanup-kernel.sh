#!/usr/bin/env bash
#?
# clean-kernel.sh - Cleanup old kernel artifacts in boot partition
#
# USAGE
#
#    cleanup-kernel.sh OPTIONS
#
# OPTIONS
#
#    -d                   Don't delete files, just print files which will be
#                         deleted. Exits != 0 if files will be deleted.
#
# BEHAVIOR
#
#    Delete config, initramfs, vmlinuz, and System.map files from the boot
#    partition for old kernel versions.
#
#?

# Exit on any error
set -e

function die() {
    echo "Error: $@" >&2
    exit 1
}

# Options
while getopts "d" opt; do
    case "$opt" in
	   d) dry_run="true" ;;
	   '?') die "Uknown option" ;;
    esac
done

# Remove old files
cd /boot
files_deleted=0

function remove_file() {
    files_deleted=$(($files_deleted + 1))
    
    if [ -n "$dry_run" ]; then
	   echo "[dry run] rm $1"
    else
	   echo "rm $1"
	   if ! rm "$1"; then
		  die "Failed to remove $1 file"
	   fi
    fi
}

# Find newest kernel version
newest_found=false
newest_major="-1"
newest_minor="-1"
newest_patch="-1"
newest_pkg="-1"

for f in $(ls /boot | grep '\(config\|initramfs\|vmlinuz\|System.map\)-[[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+_[[:digit:]]\+*'); do
    version=$(echo "$f" | sed 's/.*-\([[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+_[[:digit:]]\+\).*/\1/')

    major=$(echo "$f" | sed 's/.*-\([[:digit:]]\+\).\([[:digit:]]\+\).\([[:digit:]]\+\)_\([[:digit:]]\+\).*/\1/')
    minor=$(echo "$f" | sed 's/.*-\([[:digit:]]\+\).\([[:digit:]]\+\).\([[:digit:]]\+\)_\([[:digit:]]\+\).*/\2/')
    patch=$(echo "$f" | sed 's/.*-\([[:digit:]]\+\).\([[:digit:]]\+\).\([[:digit:]]\+\)_\([[:digit:]]\+\).*/\3/')
    pkg=$(echo "$f" | sed 's/.*-\([[:digit:]]\+\).\([[:digit:]]\+\).\([[:digit:]]\+\)_\([[:digit:]]\+\).*/\4/')

    current_newer=false
    
    if (( $major > $newest_major )); then
	   current_newer=true
    elif (( $major == $newest_major )); then
	   if (( $minor > $newest_minor )); then
		  current_newer=true
	   elif (( $minor == $newest_minor )); then
		  if (( $patch > $newest_patch )); then
			 current_newer=true
		  elif (( $patch == $newest_patch )); then
			 if (( $pkg > $newest_pkg )); then
				current_newer=true
			 fi
		  fi
	   fi
    fi

    if [[ "$current_newer" == "true" ]]; then
	   newest_found=true
	   newest_major="$major"
	   newest_minor="$minor"
	   newest_patch="$patch"
	   newest_pkg="$pkg"
    fi
done

if [[ "$newest_found" != "true" ]]; then
    die "Failed to find newest kernel version"
else
    echo "Newest kernel package version: $newest_major.$newest_minor.${newest_patch}_$newest_pkg"
fi

# Delete old files
for f in $(ls /boot | grep '\(config\|initramfs\|vmlinuz\|System.map\)-[[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+_[[:digit:]]\+*'); do
    if ! echo "$f" | grep ".*-$newest_major.$newest_minor.${newest_patch}_$newest_pkg.*" > /dev/null; then
	   remove_file "$f"
    fi
done

# Indicate status of files
if [[ "$dry_run" == "true" && "$files_deleted" == "0" ]]; then
    echo "$files_deleted files deleted"
    exit 1
elif [[ "$files_deleted" == "0" ]]; then
    echo "No files deleted"
fi
