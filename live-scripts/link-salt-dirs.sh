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
repo_dir=/etc/linux-install
salt_content_dir=/srv



salt_state_links=(
    "$repo_dir/salt/base:$salt_content_dir/salt/base"
    "$repo_dir/salt/work:$salt_content_dir/salt/work"
    "$repo_dir/salt/work:$salt_content_dir/salt/wsl"
    "$repo_dir/secrets/salt/base:$salt_content_dir/salt/base-secret"
)

salt_pillar_links=(
    "$repo_dir/pillar/base:$salt_content_dir/pillar/base"
    "$repo_dir/pillar/work:$salt_content_dir/pillar/work"
    "$repo_dir/pillar/work:$salt_content_dir/pillar/wsl"
    "$repo_dir/secrets/pillar/base:$salt_content_dir/pillar/base-secret"
)

# Parse options
while getopts "hspa" opt; do
    case "$opt" in
	h) cat <<EOF
link-salt-dirs.sh - Link Salt directories

USAGE

    link-salt-dirs.sh [-h,-s,-p,-a]

OPTIONS

    -h    Show this help text
    -s    Print space seperated list of link information for Salt state directories
    -p    Print space seperated list of link information for Salt pillar directories
    -a    Print space seperated list of link information for Salt state and pillar directories

BEHAVIOR

    Creates symbolic links from this repository's Salt state and pillar directories to the 
    system's global directories where Salt expects them. Mainly in /srv/{salt,pillar}.

    This script also provides an interface to learn information about the structure of this
    repository. The -s,-p, and -a options do not create any links. Instead they return a space
    seperated list of link information. Each item in this list is in the format:

        <directory in repository>:<link target>

EOF
	   exit 0
	   ;;
	s)
	    echo "${salt_state_links[@]}"
	    exit 0
	    ;;
	p)
	    echo "${salt_pillar_links[@]}"
	    exit 0
	    ;;
	a)
	    echo "${salt_state_links[@]} ${salt_pillar_links[@]}"
	    exit 0
	    ;;
	'?') die "Unknown option" ;;
    esac
done

# Link
test -d "$repo_dir"
check "Repository directory \"$repo_dir\" doesn't exist"

mkdir -p "$salt_content_dir"
check "Failed to make parent directory for links \"$salt_content_dir\""

for subdir in salt pillar; do
    mkdir -p "$salt_content_dir/$subdir"
    check "Failed to make parent directory for links \"$salt_content_dir/$subdir\""
done

bold "Linking"
for link_info in "${salt_state_links[@]}" "${salt_pillar_links[@]}"; do
	original_dir=$(echo "$link_info" | awk -F ':' '{ print $1 }')
	link_dir=$(echo "$link_info" | awk -F ':' '{ print $2 }')
	
	# Check if link exists
	if [ -L "$link_dir" ]; then
		echo "Link \"$link_dir\" already exists, skipping"
		continue
	fi

	# Link
	ln -s "$original_dir" "$link_dir"
	check "Failed to link \"$link_dir\" -> \"$original_dir\""
	echo "Linked \"$link_dir\" -> \"$original_dir\""
done

bold "Linked"
