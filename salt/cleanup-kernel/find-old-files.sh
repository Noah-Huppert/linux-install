#!/usr/bin/env bash
#?
# find-old-files.sh - List old kernel artifacts in boot partition
#
# USAGE
#
#    find-old-files.sh OPTIONS
#
# OPTIONS
#
#    -v CUR_KERNEL_VER    Current kernel version
#    -e                   (Optional) Exit with non-zero exit code if any old files exist
#
# BEHAVIOR
#
#    Print config, initramfs, vmlinuz, and System.map files in the boot
#    partition for old kernel versions.
#
#    If the -e option (-e or empty) exists then the script will exit with a non-zero
#    exit code if any old kernel artifacts exist.
#
#?

# {{{1 Helpers
function die() {
    echo "Error: $@" >&2
    exit 1
}

# {{{1 Options
# {{{2 Get
while getopts "v:e" opt; do
    case "$opt" in
	v) current_kernel_version="$OPTARG" ;;
	e) empty_mode="true" ;;
	'?') die "Uknown option" ;;
    esac
done

# {{{2 Verify
if [ -z "$current_kernel_version" ]; then
    die "-v CUR_KERNEL_VERSION option required"
fi

# {{{1 Find old files
empty="true"

for kernel_file_tmpl in 'config-VERSION' 'initramfs-VERSION.img' 'vmlinuz-VERSION' 'System.map-VERSION'; do
    current_version_name=$(echo "$kernel_file_tmpl" | sed "s/VERSION/$current_kernel_version/g")
    any_version_name=$(echo "$kernel_file_tmpl" | sed 's/VERSION/\*/g')

    old_files=$(find /boot -name "$any_version_name" ! -name "$current_version_name" -printf '%f\n')

    if [[ "$?" != "0" ]]; then
	die "Failed to find old Kernel artifacts with name $kernel_file"
    fi

    echo "$old_files"

    if [ -n "$old_files" ] && [ -n "$empty_mode" ]; then
	empty="false"
    fi
done

# {{{1 Exit with non-zero code if -e provided
if [[ "$empty" == "false" ]]; then
    echo "Found old Kernel files"
    exit 1
fi
