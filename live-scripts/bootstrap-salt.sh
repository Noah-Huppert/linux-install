#!/usr/bin/env bash

# Helpers
function die() {
    echo "Error: $@" >&2
    exit 1
}


function bold() {
    echo "$(tput bold)$@$(tput sgr0)"
}

function check() {
    if [ "$?" -ne 0 ]; then
        die "$@"
    fi
}

# Configuration
prog_dir=$(realpath $(dirname "$0"))

python=python3

salt_ubuntu_repo=https://repo.saltstack.com/salt_rc/py3/ubuntu/20.04/amd64
salt_ubuntu_repo_key_sig=0E08A149DE57BFBE
ubuntu_repos_file=/etc/apt/sources.list

repo_dir=/etc/linux-install
salt_content_dir=/srv
salt_minion_config=/etc/salt/minion

salt_state_dirs=($("$prog_dir/link-salt-dirs.sh" -s))
check "Failed to get a list of Salt state directories"

salt_pillar_dirs=($("$prog_dir/link-salt-dirs.sh" -p))
check "Failed to get a list of Salt pillar directories"

# Parse arguments
opt_env=base

while getopts "spe:hf" opt; do
    case "$opt" in
	s)
	    opt_install_salt_src=true
	    opt_install_salt_pkg=""
	    ;;
	p)
	    opt_install_salt_src=""
	    opt_install_salt_pkg=true
	    ;;
	e) opt_env="$OPTARG" ;;
        h) cat <<EOF
bootstrap-salt.sh - Sets up Salt on the current system

USAGE

    bootstrap-salt.sh -s|-p [-e ENV,-h,-f]
    
OPTIONS

    -s        Install Salt from source
    -p        Install Salt from a package
    -e ENV    Salt environment to setup, defaults to "base"
    -h        Show this help text
    -f        Force installation even if Salt is already installed
    
BEHAVIOR

    Installs Salt either from source of from a package.

    Installing from source clones down the Salt repository and uses the setup.py script.
    Installing from a package is only supported for Ubuntu 20.04 and Void Linux 
    right now.

    After Salt is installed symbolic links are made for Salt directories.
    
    This script is usually not part of the automated setup flow described
    in the ../INSTRUCTIONS.md file. However it can be useful when one wants
    to use Salt with this repository but not use the prescibed automated 
    setup flow.
EOF
        exit 0;
    ;;
    f) opt_force=true ;;
    '*') die "Unknown option" ;;
    esac
done

# Check an installation method was choosen
if [ -z "$opt_install_salt_src" ] && [ -z "$opt_install_salt_pkg" ]; then
    echo "$opt_install_salt_src"
    echo "$opt_install_salt_pkg"
    die "An installation method must be choosen via the -s or -p option"
fi

# Check environment exists
test -d "$repo_dir/pillar/$opt_env"
check "Environment \"$opt_env\" specified by the -e option does not exist"

# Check if root
if [[ "$EUID" != "0" ]]; then
    die "Must run as root"
fi

# Install Salt from source
if [ -n "$opt_install_salt_src" ]; then
    # Check for dependencies
    missing_bins=()
    for bin in git "$python"; do
	if ! which "$bin" &> /dev/null; then
	    missing_bins+=("$bin")
	fi
    done

    if [ -n "$missing_bins" ]; then
	die "The following binaries must be available: ${missing_bins[@]}"
    fi

    if ! "$python" -c "import setuptools" &> /dev/null; then
	if uname -a | grep Ubuntu &> /dev/null; then
	    python_setuptools_note=" (Install a package named ~ python3-setuptools)"
	fi

	die "Python setuptools must be installed$python_setuptools_note"
    fi

    if ! find /**/include -type f -name Python.h &> /dev/null; then
	die "Python development headers must be installed (Checked $(ls -d /**/include) for Python.h)"
    fi

    # Check that Salt isn't already installed
    if which salt-call &> /dev/null && [ -z "$opt_force" ]; then
	bold "Salt already installed: $(which salt-call)"
    else
	# Clone down salt repository
	salt_repo_uri="https://github.com/saltstack/salt.git"
	salt_repo_dir=/tmp/salt
	bold "Cloning Salt repository into $salt_repo_dir"

	if [ ! -d "$salt_repo_dir" ]; then
	    git clone --depth 1 "$salt_repo_uri" "$salt_repo_dir"
	    check "Failed to clone salt repository"
	else
	    echo "Already cloned"
	fi

	# Checkout latest stable version
	salt_tag=v3000.3
	bold "Checking out Salt version \"$salt_tag\""

	cd "$salt_repo_dir"
	check "Failed to navigate into Salt repository located at \"$salt_repo_dir\""

	git fetch origin --tags
	check "Failed to get version of Salt"

	git checkout "$salt_tag"
	check "Failed to checkout Salt version \"$salt_tag\""

	# Install Salt
	bold "Installing Salt"

	"$python" setup.py install
	check "Failed to install Salt"

	# Check Salt installation worked
	if ! which salt-call &> /dev/null; then
	    die "Salt installed but cannot find the salt-call binary"
	fi

	bold "Salt installed"

	bold "Cleaning up installation"
	rm -rf "$salt_repo_dir"
	check "Failed to delete Salt repository after successful install"
    fi
fi

# Install Salt from package
if [ -n "$opt_install_salt_pkg" ]; then
    # Check if this is Ubuntu or Void linux
    pkg_manager=""
    if uname -a | grep "Ubuntu" &> /dev/null; then
	   pkg_manager=apt
    elif which xbps-install &> /dev/null; then
	   pkg_manager=xbps
    fi

    if [ -z "$pkg_manager" ]; then
	   die "Package installation mode is only supported on Ubuntu and Void linux"
    fi

    # Check that Salt isn't already installed
    if which salt-call &> /dev/null && [ -z "$opt_force" ]; then
	   bold "Salt already installed: $(which salt-call)"
    else
	   case "$pkg_manager" in
		  ubuntu)
			 # Install custom apt repository manager
			 if ! which add-apt-repository &> /dev/null; then
				bold "Installing dependencies"
				apt install -y software-properties-common
				check "Failed to install the add-apt-repository tool"
			 fi

			 # Ensure that the Salt PPA is configured
			 if ! cat "$ubuntu_repos_file" | grep "$salt_ubuntu_repo" &> /dev/null; then
				apt-key adv --keyserver keyserver.ubuntu.com --recv-keys "$salt_ubuntu_repo_key_sig"
				check "Failed to retrieve the APT Salt repository's signing key"
				
				apt update
				check "Failed to update APT after adding the Salt repository"
			 fi
			 
			 # Install Salt
			 apt install -y salt-minion
			 check "Failed to install Salt"
			 ;;
		  xbps)
			 # Install Salt
			 xbps-install -Syu salt
			 check "Failed to install Salt"
			 ;;
	   esac
    fi
    

    # Check Salt installation worked
    if ! which salt-call &> /dev/null; then
	   die "Salt installed but cannot find the salt-call binary"
    fi

    bold "Salt installed"
fi

# Make links
"$prog_dir/link-salt-dirs.sh"
check "Failed to link Salt directories"

# Check if Salt isn't already configured
if [ -f "$salt_minion_config" ] && cat "$salt_minion_config" | grep "STATE_SALT_CONFIGURATION_RUN_ENV_$opt_env" &> /dev/null && [ -z "$opt_force" ]; then
    bold "Salt already configured"
else
    bold "Configuring Salt"

    # Make bootstrap minion configuration
    mkdir -p /etc/salt
    check "Failed to make Salt configuration directory"

    cat <<EOF > "$salt_minion_config"
saltenv: $opt_env
pillarenv: $opt_env

file_roots:
  $opt_env:
EOF
    check "Failed to write initial part of bootstrap Salt minion configuration"

    salt_state_dirs_last=()
    for link_info in "${salt_state_dirs[@]}"; do
	# Ensure that directories for the specified environment appear first in the list
	# This is because Salt will use the first state it finds, so we want to ensure that
	# the current environment will always be checked first.
	if ! echo "$link_info" | grep "$opt_env" &> /dev/null; then
	    salt_state_dirs_last+=("$link_info")
	else
	    echo "    - $(echo $link_info | awk -F ':' '{ print $2 }')" >> "$salt_minion_config"
	    check "Failed to write Salt state directory to bootstrap Salt minion configuration"
	fi
    done

    for link_info in "${salt_state_dirs_last[@]}"; do
	echo "    - $(echo $link_info | awk -F ':' '{ print $2 }')" >> "$salt_minion_config"
	    check "Failed to write Salt state directory to bootstrap Salt minion configuration"
    done
    
    cat <<EOF >> "$salt_minion_config" 

pillar_roots:
  $opt_env:
    - $salt_content_dir/pillar/$opt_env

ext_pillar:
  - stack:
      pillar:environment:
        $opt_env:
EOF
    check "Failed to write a block related to pillar directories to bootstrap Salt configuration"

    salt_pillar_dirs_last=()
    for link_info in "${salt_pillar_dirs[@]}"; do
	# Ensure that pillar directories for the current environment are placed last.
	# This is because the last pillar will override all existing values, so we want the
	# current environment's pillars to be able to override.
	if echo "$link_info" | grep "$opt_env"; then
	    salt_pillar_dirs_last+=("$link_info")
	else
	    echo "          - $(echo $link_info | awk -F ':' '{ print $2 }')/pillar-stack.cfg" >> "$salt_minion_config"
	    check "Failed to write Pillar stack configuration file location to bootstrap Salt minion configuration"
	fi
    done

    for link_info in "${salt_pillar_dirs_last[@]}"; do
	echo "          - $(echo $link_info | awk -F ':' '{ print $2 }')/pillar-stack.cfg" >> "$salt_minion_config"
	check "Failed to write Pillar stack configuration file location to bootstrap Salt minion configuration"
    done

    # Run Salt state to get real Salt configuration
    "$repo_dir/salt/base/salt-apply-script/salt-apply" -s salt-configuration
    check "Failed to run Salt state to create real Salt configuration"
fi

bold "Bootstrapped"
