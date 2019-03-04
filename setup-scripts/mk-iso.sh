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
mklive_dir="/opt/void-mklive"

arch_x86_64_glibc="x86_64"
arch_x86_64_musl="x86_64-musl"

# {{{1 Check if running on Void
if ! lsb_release -c | grep 'void' &> /dev/null; then
	echo "$0 can only be run on Void Linux due to compatibility issues with XBPS tools" >&2
	exit 1
fi

# {{{1 Options
# {{{2 Get
while getopts "o:a:h" opt; do
	case "$opt" in
		o)
			iso_out="$OPTARG"
			;;

		a)
			arch="$OPTARG"
			;;

		h)
			echo "$0 -o ISO_OUT -a ARCH [-h]"
			exit 1
			;;

		'?')
			echo "Error: Unknown option \"$opt\"" >&2
			exit 1
			;;
	esac
done

# {{{2 Verify
# {{{3 iso_out
if [ -z "$iso_out" ]; then
	echo "Error: -o ISO_OUT option required" >&2
	exit 1
fi

# {{{3 arch
if [ -z "$arch" ]; then
	echo "Error: -a ARCH option required" >&2
	exit 1
fi

if [[ "$arch" != "$arch_x86_64_glibc" && "$arch" != "$arch_x86_64_musl" ]]; then
	echo "Error: -a ARCH must be one of: $arch_x86_64_glibc, $arch_x86_64_musl" >&2
	exit 1
fi

# {{{1 Check for required software
echo "#############################"
echo "# Checking For Dependencies #"
echo "#############################"

for prog in curl tar unzip make xz git; do
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
for lib in liblz4.so.1 libreadline.so.8; do
	# Check if library file exists
	if ! ls /usr/lib | grep "$lib" &> /dev/null; then
		# Determine package to install
		case "$lib" in
			liblz4.so.1)
				pkg_name="liblz4"
				;;

			libreadline.so.8)
				pkg_name="readline-devel"
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
if [ ! -d "$mklive_dir" ]; then
	if ! git clone "https://github.com/void-linux/void-mklive.git" "$mklive_dir"; then
		echo "Error: Failed to download void-linux/void-mklive" >&2
		exit 1
	fi
fi

# {{{2 Build
mklive_sh="$mklive_dir/mklive.sh"

if [ ! -f "$mklive_sh" ]; then
	if ! make -C "$mklive_dir"; then
		echo "Error: Failed to build void-linux/void-mklive" >&2
		exit 1
	fi
else
	echo "Already built"
fi

# {{{1 Make Void ISO
echo "###################"
echo "# Build Void ISO #"
echo "###################"

# {{{2 If iso doesn't exist, make
if [ ! -f "$iso_out" ]; then
	# {{{3 Check running as sudoer
	echo "Running $mklive_sh as sudo, may prompt for your sudo password"

	if [[ "$EUID" != "0" ]]; then
		mklive_run_args="sudo"
	fi

	# {{{3 Run commands in void-mklive dir
	cd "$mklive_dir"

	# {{{3 Make ISO
	if ! $mklive_run_args \
		"$mklive_sh" \
		-o "$iso_out" \
		-a "$arch"; then
		echo "Error: Failed to build Void Linux ISO" >&2
		exit 1
	fi
else
	echo "Already built"
fi

echo "DONE"
