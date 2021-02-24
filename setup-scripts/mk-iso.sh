#!/usr/bin/env bash
# Configuration
prog_dir=$(realpath $(dirname "$0"))

mklive_dir="/opt/void-mklive"

iso_pkgs="emacs cryptsetup curl unzip"

iso_rootfs_dir="/var/tmp/void-mklive-tmp-iso-rootfs"

arch_x86_64_glibc="x86_64"
arch_x86_64_musl="x86_64-musl"

kernel_version="linux5.4"

# Helpers
function die() {
    echo "Error: $@" >&2
    exit 1
}

# Check if running on Void
if ! lsb_release -c | grep 'void' &> /dev/null; then
    die "$0 can only be run on Void Linux due to compatibility issues with XBPS tools"
fi

# Options
# Get
while getopts "o:a:m:fh" opt; do
    case "$opt" in
	o) iso_out="$OPTARG"  ;;
	a) arch="$OPTARG"  ;;
	f) force_iso="true" ;;
	m) mklive_dir="$OPTARG" ;;
	h) cat<<EOF
mk-iso.sh - Creates a Void Linux live ISO

USAGE

    mk-iso.sh -o ISO_OUT -a ARCH [-m MKLIVE_DIR,-f,-h]

OPTIONS

    -o ISO_OUT       Location to write ISO
    -a ARCH          Architecture to build ISO of
    -m MKLIVE_DIR    (Optional) Alternate directory which contains void-mklive tool
    -f               (Optional) Force ISO to be rebuilt
    -h               (Optional) Show help text

BEHAVIOR

    Can only be run on Void Linux due to compatibility issues
    with XBPS tools.

    Creates an ISO with requires programs and libraries.
EOF
	   exit 1
	   ;;
	'?')
	    die "Unknown option \"$opt\""
	    ;;
    esac
done

# Verify
# iso_out
if [ -z "$iso_out" ]; then
    die "-o ISO_OUT option required"
fi

# arch
if [ -z "$arch" ]; then
    die "-a ARCH option required"
fi

if [[ "$arch" != "$arch_x86_64_glibc" && "$arch" != "$arch_x86_64_musl" ]]; then
    die "-a ARCH must be one of: $arch_x86_64_glibc, $arch_x86_64_musl"
fi

# Process
# mklive_dir
mklive_sh="$mklive_dir/mklive.sh"

# Check if ISO has already been built
if [ -f "$iso_out" ]; then
    if [ -z "$force_iso" ]; then
	die "$iso_out already exists"
    else
	if ! rm "$iso_out"; then
	    die "Failed to delete old ISO file: $iso_out"
	fi
    fi
fi

# Check for dependencies
pkgs_to_install=()

# Software
# The python-pip, python-devel, and gcc packages are only installed right now
# because of https://github.com/Noah-Huppert/linux-install/issues/5#issuecomment-609474103
if ! xbps-install -Sy \
	curl \
	tar \
	unzip \
	make \
	xz \
	git \
	python-pip \
	python-devel \
	gcc \
	salt; then
    die "Failed to install required software into ISO"
fi

if ! pip2 install 'msgpack==0.6.2' pycrypto 'futures>=2.0'; then
    die "Failed to install dependencies of the software Salt into the ISO"
fi

# Libraries
for lib in liblz4 libreadline; do
    if ! ls /usr/lib | grep "$lib" &> /dev/null; then
	   case "$lib" in
		  liblz4) pkg_name="liblz4"  ;;
		  libreadline) pkg_name="readline-devel"  ;;
	   esac

	   echo "$lib library not found, will install $pkg_name"
	   pkgs_to_install+=("$pkg_name")
    fi
done

echo "pkgs_to_install: $pkgs_to_install"

# Install packages if required
if [ -n "$pkgs_to_install" ]; then
    if ! xbps-install -Sy "${pkgs_to_install[@]}"; then
	die "Failed to install dependencies: ${pkgs_to_install[@]}"
    fi
fi

# void-mklive
if [ ! -d "$mklive_dir" ]; then
    # Download
    if ! git clone "https://github.com/void-linux/void-mklive.git" "$mklive_dir"; then
	die "Failed to download void-mklive"
    fi

    # Build
    if ! make -C "$mklive_dir"; then
	die "Failed to build void-linux/void-mklive"
    fi
fi

# Make Void ISO
# Check running as sudoer
if [[ "$EUID" != "0" ]]; then
    mklive_run_args="sudo"

    echo "Running $mklive_sh with \"sudo\", you may be prompted for your password"
fi

# Construct ISO rootfs
# Make cleanup ISO rootfs directory on exit
function iso_rootfs_cleanup() {
    if [ -d "$iso_rootfs_dir" ]; then
	if ! rm -rf "$iso_rootfs_dir"; then
	    die "Failed to delete ISO root file system directory: $iso_rootfs_dir"
	fi
    fi
}

#trap iso_rootfs_cleanup EXIT

# Make ISO rootfs directory
if ! mkdir -p "$iso_rootfs_dir"; then
    die "Failed to create ISO root file system directory: $iso_rootfs_dir"
fi

# Copy this repository into ISO rootfs
if ! mkdir -p "$iso_rootfs_dir/etc"; then
    die "Failed to create repository directory in ISO root file system"
fi

if ! cp -R "$(realpath $prog_dir/..)/" "$iso_rootfs_dir/etc"; then
    die "Failed to copy repository into ISO root file system"
fi

# Make ISO
if ! cd "$mklive_dir"; then
    die "Failed to change into mklive directory: $mklive_dir"
fi

if ! ${mklive_run_args[@]} "$mklive_sh" \
     -o "$iso_out" \
     -p "$iso_pkgs" \
     -I "$iso_rootfs_dir" \
     -a "$arch" \
     -v "$kernel_version"; then

    die "Failed to build Void Linux ISO"
fi

echo "Created $iso_out"
