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
#	-r        (Optional) Redownload linux-install even if it exists
#    -e ENV    (Optional) Specify salt environment to use. Defaults to "base".
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

# {{{1 Configuration
prog_dir=$(realpath $(dirname "$0"))

dependencies=("curl" "unzip" "git")

repo_url="https://github.com/Noah-Huppert/linux-install.git"
repo_dir="/etc/linux-install"

salt_parent_dir="/srv"

# {{{1 Helpers
function die() {
	echo "Error: $@" >&2
	exit 1
}

# {{{1 Options
salt_env=base
while getopts "re:" opt; do
	case "$opt" in
	    r) redownload="true" ;;
	    e) salt_env="$OPTARG" ;;
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
if [ -d "$repo_dir" ] && [ -n "$redownload" ]; then
	if ! rm -rf "$repo_dir"; then
		die "Failed to delete linux-install directory so it can be re-downloaded"
	fi
fi

# {{{2 Download if directory not present
if [ ! -d "$repo_dir" ]; then
	echo "#############################"
	echo "# Downloading linux-install #"
	echo "#############################"

	# {{{3 Clone
	if ! git clone "$repo_url" "$repo_dir"; then
		die "Failed to clone linux-install"
	fi

	# {{{3 Modify submodules to use https
	cd "$repo_dir"

	tmp_gitmodules="/tmp/gitmodules"

	if ! cat .gitmodules | sed 's/git@github.com:/https:\/\/github.com\//g' > "$tmp_gitmodules"; then
		die "Failed to update gitmodules to use https"
	fi

	if ! mv "$tmp_gitmodules" ".gitmodules"; then
		die "Failed to move updated gitmodules file"
	fi

	# {{{3 Initialize submodules
	if ! git submodule update --init --recursive; then
		die "Failed to initialize linux install Git submodules"
	fi
fi

# {{{2 Link
if ! "$prog_dir/link-salt-dirs.sh"; then
    die "Failed to link Salt directories"
fi

# {{{1 Apply salt states
echo "########################"
echo "# Applying Salt states #"
echo "########################"

# {{{2 Configure just Salt minion so we can read all our states
if ! salt-call --local state.apply salt-configuration saltenv="$salt_env" pillarenv="$salt_env"; then
	die "Failed to apply salt-configuration Salt state"
fi

# {{{2 Run highstate
if ! salt-call --local state.apply saltenv="$salt_env" pillarenv="$salt_env"; then
	die "Failed to apply Salt high state"
fi
