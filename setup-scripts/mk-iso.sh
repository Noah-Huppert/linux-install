#!/usr/bin/env bash
#?
# mk-iso.sh - Creates a Void Linux live ISO
#
# USAGE
#
#	mk-iso.sh OPTIONS
#
# OPTIONS
#
#	-o ISO_OUT    Location to write ISO
#	-a ARCH       Architecture to build ISO of
#	-f            Force ISO to be rebuilt
#	-h            Show help text
#
# BEHAVIOR
#
# 	Can only be run on Void Linux due to compatibility issues
#	with XBPS tools.
#
# 	The script first installs required programs and libraries. 
#
#?

# {{{1 Exit on any error
set -e

# {{{1 Configuration
prog_dir=$(realpath $(dirname "$0"))

mklive_dir="/opt/void-mklive"
mklive_sh="$mklive_dir/mklive.sh"

iso_pkgs="neovim cryptsetup curl unzip"

iso_rootfs_dir="/var/tmp/void-mklive-tmp-iso-rootfs"
iso_rootfs_repo_dir="$iso_rootfs_dir/opt/linux-install"

arch_x86_64_glibc="x86_64"
arch_x86_64_musl="x86_64-musl"

# {{{1 Helpers
function die() {
	echo "Error: $@" >&2
	exit 1
}

# {{{1 Check if running on Void
if ! lsb_release -c | grep 'void' &> /dev/null; then
	die "$0 can only be run on Void Linux due to compatibility issues with XBPS tools"
fi

# {{{1 Options
# {{{2 Get
while getopts "o:a:h" opt; do
	case "$opt" in
		o) iso_out="$OPTARG"  ;;
		a) arch="$OPTARG"  ;;
		f) force_iso="true" ;;
		h)
			echo "$0 -o ISO_OUT -a ARCH [-f,-h]"
			exit 1
			;;

		'?')
			die "Unknown option \"$opt\""
			;;
	esac
done

# {{{2 Verify
# {{{3 iso_out
if [ -z "$iso_out" ]; then
	die "-o ISO_OUT option required"
fi

# {{{3 arch
if [ -z "$arch" ]; then
	die "-a ARCH option required"
fi

if [[ "$arch" != "$arch_x86_64_glibc" && "$arch" != "$arch_x86_64_musl" ]]; then
	die "-a ARCH must be one of: $arch_x86_64_glibc, $arch_x86_64_musl"
fi

# {{{1 Check if ISO has already been built
if [ -f "$iso_out" ]; then
	if [ -z "$force_iso" ]; then
		die "$iso_out already exists"
	else
		if ! rm "$iso_out"; then
			die "Failed to delete old ISO file: $iso_out"
		fi
	fi
fi

# {{{1 Check for dependencies
pkgs_to_install=()

# {{{2 Software
for prog in curl tar unzip make xz git; do
	if ! which "$prog" &> /dev/null; then
		echo "will install $prog"
		pkgs_to_install+=("$prog")
	fi
done

# {{{2 Libraries
for lib in liblz4 libreadline; do
	if ! ls /usr/lib | grep "$lib" &> /dev/null; then
		case "$lib" in
			liblz4) pkg_name="liblz4"  ;;

			libreadline) pkg_name="readline-devel"  ;;
		esac

		echo "$lib library not found, will install $pkg_name"
		pkgs_to_install+=("$prog")
	fi
done

# {{{2 Install packages if required
if [ ! -z "$pkgs_to_install" ]; then
	if ! xbps-install -Sy "${pkgs_to_install[@]}"; then
		die "Failed to install dependencies: ${pkgs_to_install[@]}"
	fi
fi

# {{{2 void-mklive
if [ ! -d "$mklive_dir" ]; then
	# {{{3 Download
	if ! git clone "https://github.com/void-linux/void-mklive.git" "$mklive_dir"; then
		die "Failed to download void-mklive"
	fi

	# {{{3 Build
	if ! make -C "$mklive_dir"; then
		die "Failed to build void-linux/void-mklive"
	fi
fi

# {{{1 Make Void ISO
# {{{2 Check running as sudoer
if [[ "$EUID" != "0" ]]; then
	mklive_run_args="sudo"

	echo "Running $mklive_sh with \"sudo\", you may be prompted for your password"
fi

# {{{2 Construct ISO rootfs
# {{{3 Make cleanup ISO rootfs directory on exit
function iso_rootfs_cleanup() {
	if [ -d "$iso_rootfs_dir" ]; then
		if ! rm -rf "$iso_rootfs_dir"; then
			die "Failed to delete ISO root file system directory: $iso_rootfs_dir"
		fi
	fi
}

trap iso_rootfs_cleanup EXIT

# {{{3 Make ISO rootfs directory
if ! mkdir -p "$iso_rootfs_dir"; then
	die "Failed to create ISO root file system directory: $iso_rootfs_dir"
fi

# {{{3 Copy this repository into ISO rootfs
if ! mkdir -p "$iso_rootfs_repo_dir"; then
	die "Failed to create repository directory in ISO root file system"
fi

if ! cp -R "$prog_dir/" "$iso_rootfs_repo_dir"; then
	die "Failed to copy repository into ISO root file system"
fi

# {{{2 Make ISO
if ! cd "$mklive_dir" && ${mklive_run_args[@]} \
	"$mklive_sh" \
	-o "$iso_out" \
	-p "$iso_pkgs" \
	-I "$iso_rootfs_dir" \
	-a "$arch"; then

	die "Failed to build Void Linux ISO"
fi

echo "Created $iso_out"
