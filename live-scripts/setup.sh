#!/usr/bin/env bash
#?
# setup.sh - Configure and install programs in Linux environment
#
# USAGE
#
# 	setup.sh OPTIONS
#
# OPTIONS
#
#	-r    (Optional) Redownload linux-install even if it exists
#
# BEHAVIOR
#
#	Runs Salt to setup an already installed Linux environment.
#
#	Pre-conditions: Connected to wifi, Salt installed.
#
#	Can be run on multiple times on an existing Linux installation.
#
#?

# {{{1 Exit on any error
set -e

# {{{1 Configuration
dependencies=("curl" "unzip" "git")

linux_install_repo="https://github.com/Noah-Huppert/linux-install.git"
linux_install_dir="/etc/linux-install"

salt_parent_dir="/srv"

linux_install_states_dir="$linux_install_dir/salt"
linux_install_pillars_dir="$linux_install_dir/pillar"

linux_install_states_link="$salt_parent_dir/salt"
linux_install_pillars_link="$salt_parent_dir/pillar"

# {{{1 Helpers
function die() {
	echo "Error: $@" >&2
	exit 1
}

# {{{1 Options
while getopts "r" opt; do
	case "$opt" in
		r) redownload="true" ;;
		'?') die "Unknown option" ;;
	esac
done

# {{{1 Install software dependencies
install_dependencies=()

for dep in "${dependencies[@]}"; do
	# {{{2 Check if exists
	if which "$dep" &> /dev/null; then
		continue
	fi

	# {{{2 Install if doesn't exist
	install_dependencies+=("$dep")
done

if [ ! -z "$install_dependencies" ]; then
	echo "###########################"
	echo "# Installing dependencies #"
	echo "###########################"

	if ! xbps-install -Sy "${install_dependencies[@]}"; then
		die "Failed to install dependencies: ${install_dependencies[@]}"
	fi
fi

# {{{1 Download linux-install repository 
# {{{2 If redownload option is set, delete linux-install directory if present
if [ -d "$linux_install_dir" ] && [ -n "$redownload" ]; then
	if ! rm -rf "$linux_install_dir"; then
		die "Failed to delete linux-install directory so it can be re-downloaded"
	fi
fi

# {{{2 Download if directory not present
if [ ! -d "$linux_install_dir" ]; then
	echo "#############################"
	echo "# Downloading linux-install #"
	echo "#############################"

	# {{{3 Clone
	if ! git clone --recurse-submodules "$linux_install_repo" "$linux_install_dir"; then
		die "Failed to clone linux-install"
	fi
fi

# {{{2 Ensure Salt parent directory exists
if [ ! -e "$salt_parent_dir" ]; then
	if ! mkdir -p "$salt_parent_dir"; then
		die "Failed to make Salt parent directory"
	fi
fi

# {{{2 Link Salt states
if [ ! -e "$linux_install_states_link" ]; then
	# {{{2 Link
	if ! ln -s "$linux_install_states_dir" "$linux_install_states_link"; then
		die "Failed to link Salt states directory"
	fi
fi

# {{{2 Link Salt pillars
if [ ! -e "$linux_install_pillars_link" ]; then
	if ! ln -s "$linux_install_pillars_dir" "$linux_install_pillars_link"; then
		die "Failed to link Salt pillars directory"
	fi
fi

# {{{1 Apply salt states
echo "########################"
echo "# Applying Salt states #"
echo "########################"

if ! salt-call --local state.apply; then
	die "Failed to apply Salt states"
fi
