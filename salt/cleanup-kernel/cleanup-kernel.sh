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
#    -v CUR_KERNEL_VER    Current kernel version
#    -d                   (Optional) Run in dry run mode
#
# BEHAVIOR
#
#    Delete config, initramfs, vmlinuz, and System.map files from the boot
#    partition for old kernel versions.
#
#?

# {{{1 Exit on any error
set -e

# {{{1 Helpers
function die() {
    echo "Error: $@" >&2
    exit 1
}

# {{{1 Options
# {{{2 Get
while getopts "v:d" opt; do
    case "$opt" in
	v) current_kernel_version="$OPTARG" ;;
	d) dry_run="true" ;;
	'?') die "Uknown option" ;;
    esac
done

# {{{2 Verify
if [ -z "$current_kernel_version" ]; then
    die "-v CUR_KERNEL_VERSION option required"
fi

# {{{1 Remove old files
cd /boot

function remove_file() {
    if [ -n "$dry_run" ]; then
	echo "[dry run] rm $1"
    else
	if ! rm "$1"; then
	    die "Failed to remove $1 file"
	fi
    fi
}

for kernel_file in config initramfs vmlinuz 'System.map'; do
    current_version_name="$kernel_file-$current_kernel_version"

    for file in $(ls $kernel_file-*); do
	if [[ "$file" != "$current_version_name" ]]; then
	    remove_file "$file"
	fi
    done
done
