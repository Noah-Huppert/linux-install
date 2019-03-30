#!/usr/bin/env bash
#?
# setup.sh - Configure and install programs in Linux environment
#
# USAGE
#
# 	setup.sh
#
# BEHAVIOR
#
#	Runs Salt to setup an already installed Linux environment.
#
#	Pre-conditions: Connected to wifi, Salt installed. Curl installed. 
#	Unzip installed.
#
#	Can be run on multiple times on an existing Linux installation.
#
#?

# {{{1 Exit on any error
set -e

# {{{1 Configuration
linux_install_download_url="https://github.com/Noah-Huppert/linux-install/archive/master.zip"
linux_install_dir="/etc/linux-install"
linux_install_states_dir="$linux_install_dir/salt"
linux_install_pillars_dir="$linux_install_dir/pillar"
linux_install_states_link="/srv/salt"
linux_install_pillars_link="/srv/pillar"

# {{{1 Helpers
function die() {
	echo "Error: $@" >&2
	exit 1
}

# {{{1 Install software dependencies
install_dependencies=()

for dep in curl; do
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

# {{{1 Download linux-install repository if not present
if [ ! -d "$linux_install_dir" ]; then
	echo "#############################"
	echo "# Downloading linux-install #"
	echo "#############################"

	# {{{2 Configuration
	linux_install_download_file="/var/tmp/linux-install-master.zip"
	linux_install_unzipped_dir="/var/tmp/linux-install-master"

	# {{{2 Exit cleanly
	function download_cleanup() {
		# Cleanup download file
		if [ -f "$linux_install_download_file" ]; then
			if ! rm "$linux_install_download_file"; then
				die "Failed to remove $linux_install_download_file file, must be removed manually"
			fi
		fi

		# Cleanup unzipped directory if the script failed when moving it
		if [ -d "$linux_install_unzipped_dir" ]; then
			if ! rm -rf "$linux_install_unzipped_dir"; then
				die "Failed to remove $linux_install_unzipped_dir directory, must be removed manually"
			fi
		fi
	}

	trap download_cleanup EXIT 

	# {{{2 Download
	if ! curl -L "$linux_install_download_url" > "$linux_install_download_file"; then
		die "Failed to download linux-install"
	fi

	# {{{2 Unzip
	if ! unzip "$linux_install_download_file"; then
		die "Failed to unzip linux-install download"
	fi

	# {{{2 Move
	if ! mv "$linux_install_unzipped_dir" "$linux_install_dir"; then
		die "Failed to move unzipped linux-install download to $linux_install_dir"
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
if ! salt-call --local state.apply; then
	die "Failed to apply Salt states"
fi
