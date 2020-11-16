#!/usr/bin/env bash

# Helpers
prog_dir=$(realpath $(dirname "$0"))

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

function show_help() {
    cat <<EOF
new-install-state.sh - Creates a new Salt state to install a package

USAGE

    new-install-state.sh [-h,-e ENV,-f,-t,-g] SRC PKG

OPTIONS

    -e ENV     Salt environment to place new state and pillar. Defaults to "base".
    -f         Override existing state.
    -t         Open editor to place new state in top files.
    -g         Commit new changes.
    -h         Show this help text.

ARGUMENTS

    SRC    Source of package. Can be "python3", "xbps", "npm", or "cargo".
    PKG    Name of package to install.

BEHAVIOR

    Creates a new Salt state which installs the specified package. The state will
    be placed in ../{salt,pillar}/ENV/PKG/init.sls. If the state's directory already
    exists the script will fail unless the -f option is provided.

    The actions for the -t and -g flags will run regardless of if the state or 
    pillars exists. The -t action will run even if the SRC and PKG arguments are
    not provided.

EOF
}

# Special action modes
function action_mode_git() {
    git reset HEAD
    check "Failed to clear any existing Git changes"

    git add $prog_dir/../{salt,pillar}/$opt_env/$PKG/init.sls
    check "Failed to add changes to Git"

    if [ -n "$top_edit_mode" ]; then
	   git add -p $prog_dir/../salt/$opt_env/top.sls
	   check "Failed to add Salt top file changes to Git"
    fi

    git commit -S -m "$PKG ($opt_env): Installed"
    check "Failed to commit changes"

    bold "Commited state \"$PKG\""
}

function action_mode_edit() {
    test -n "$EDITOR"
    check "EDITOR environment variable must be set"

    "$EDITOR" "$prog_dir/../salt/$opt_env/top.sls"
    check "Failed to edit states top file"
    bold "Editted states top file"
    exit 0
}

# Parse options
opt_env=base
while getopts "he:ftg" opt; do
    case "$opt" in
	   h)
		  show_help
		  exit 0
		  ;;
	   e) opt_env="$OPTARG" ;;
	   f) opt_force=true ;;
	   t) top_edit_mode=true ;;
	   g) git_commit_mode=true ;;
	   '?') die "Unknown option" ;;
    esac
done

shift $((OPTIND-1))

# Arguments
SRC="$1"
PKG="$2"

# Run edit top file action mode if there is an argument error
if [ -n "$top_edit_mode" ] && ([ -z "$SRC" ] || [ -z "$PKG" ]); then
    action_mode_edit
fi

if [ -z "$SRC" ]; then
    show_help
    die "SRC argument required"
fi

if [ -z "$PKG" ]; then
    show_help
    die "PKG argument required"
fi

case "$SRC" in
    python3|xbps|npm|cargo) ;;
    *)
	   show_help
	   die "SRC cannot be \"$SRC\". Must be \"python3\", \"xbps\", \"npm\", or \"cargo\"."
	   ;;
esac

SAFE_PKG=$(echo "$PKG" | sed 's/-/_/g')

# Check if state exists
state_dir="$prog_dir/../salt/$opt_env/$PKG"
state_file="$state_dir/init.sls"
if [ -f "$state_file" ]; then
    state_exists=true
fi

pillar_dir="$prog_dir/../pillar/$opt_env/$PKG"
pillar_file="$pillar_dir/init.sls"
if [ -f "$pillar_file" ]; then
    state_exists=true
fi

# Handle special action modes if state exists, before exit
if [ -n "$state_exists" ] && [ -z "$opt_force" ]; then
    if [ -n "$git_commit_mode" ]; then
	   action_mode_git
    fi

    if [ -n "$top_edit_mode" ]; then
	   action_mode_edit
    fi
fi

# Exit if state exists and not in force mode
if [ -n "$state_exists" ] && [ -z "$opt_force" ]; then
    die "State \"$PKG\" already exists, pass -f option to override"
fi

# Create state
for dir in "$state_dir" "$pillar_dir"; do
    mkdir -p "$dir"
    check "Failed to make directory \"$dir\""
done

echo "# Installs $PKG from $SRC." > "$state_file"
check "Failed to add header to state file \"$state_file\""

case "$SRC" in
    python3)
	   cat <<EOF >> "$state_file"
{{ pillar.$SAFE_PKG.pkg }}:
  pip.installed:
    - pip_bin: {{ pillar.python.pip3_bin }}
EOF
	   check "Failed to create state file \"$state_file\""
	   ;;
    xbps)
	   cat <<EOF >> "$state_file"
{{ pillar.$SAFE_PKG.pkg }}:
  pkg.installed
EOF
	   check "Failed to create state file \"$state_file\""
	   ;;
    npm)
	   cat <<EOF >> "$state_file"
{{ pillar.$SAFE_PKG.pkg }}:
  npm.installed
EOF
	   ;;
    cargo)
	   cat <<EOF >> "$state_file"
# Install for all users
{% for _, user in pillar['users']['users'].items() %}
install_cargo_${PKG}_for_{{ user.name }}:
  cmd.run:
    - name: {{ pillar.rust.cargo_bin_substitute_path }}/cargo install {{ pillar.$SAFE_PKG.pkg }}
    - runas: {{ user.name }}
    - unless: test -f {{ pillar.rust.cargo_bin_substitute_path }}/$PKG
{% endfor %}
EOF
	   ;;
esac

bold "Created state file \"$state_file\""

cat <<EOF > "$pillar_file"
$SAFE_PKG:
  pkg: $PKG
EOF
check "Failed to create pillar file \"$pillar_file\""

bold "Created pillar file \"$pillar_file\""

# Handle special action modes
if [ -n "$git_commit_mode" ]; then
    action_mode_git
fi

if [ -n "$top_edit_mode" ]; then
    action_mode_edit
fi

bold "Created state \"$PKG\" which installs \"$PKG\" from \"$SRC\""
