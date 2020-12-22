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
new-install-state.sh - Creates a new Salt state to install packages.

USAGE

    new-install-state.sh [-h,-e ENV,-f] NAME SRC PKG...

OPTIONS

    -e ENV     Salt environment to place new state and pillar. Defaults to "base".
    -f         Override existing state. If a state exists it is assumed that the pillar
               and state files were created by this tool. See BEHAVIOR section for 
               more details.
    -t         Test run, shows the diff of what would occur to the state files without
               doing anything.
    -h         Show this help text.

ARGUMENTS

    NAME    Name of the Salt state to create. Must be alphanumeric or dashes.
    SRC     Source of package. Can be "python3", "xbps", "npm", or "cargo".
    PKG     Name of package to install. Can be provided multiple times.

BEHAVIOR

    Creates a new Salt state which installs the specified packages. The state will
    be placed in ../{salt,pillar}/\$ENV/\$NAME/init.sls. In the pillar file a new object
    will be defined who's name is an underscore only version of \$NAME. Inside sub-keys 
    will be lists of packages to install. Sub-keys will follow the format 
    \$SRC_\$NAME where name is underscored only. The state file will have a simple Jinja
    loop which installs all the packages from the pillar using \$SRC. 

    If the state's directory already exists the script will fail unless the -f option is
    provided. In which case the tool will append its work onto the existing files. Be
    aware that the tool assumes it made them. So if you manually create any sub-keys in
    the pillar file which follow expected naming conventions described above everything
    will break!! Same goes for the state file.

EOF
}

# Parse options
opt_env=base
while getopts "he:ft" opt; do
    case "$opt" in
	   h)
		  show_help
		  exit 0
		  ;;
	   e) opt_env="$OPTARG" ;;
	   f) opt_force=true ;;
	   t) opt_test=true ;;
	   '?') die "Unknown option" ;;
    esac
done

shift $((OPTIND-1))

# Arguments
NAME="$1"
shift
SRC="$1"
shift
PKGS=($1)
shift

if [ -z "$NAME" ]; then
    show_help
    die "NAME argument required"
fi

if [[ !("$NAME" =~ [a-zA-Z0-9-]+) ]]; then
    die "NAME argument must only include alphanumeric characters or dashes"
fi

NAME_UNDERSCORED=$(echo "$NAME" | sed 's/_/-/g')
check "Failed to compute safe version name argument for later use (no dashes)"

if [ -z "$SRC" ]; then
    show_help
    die "SRC argument required"
fi

if [ -z "${PKGS[@]}" ]; then
    show_help
    die "PKG arguments required"
fi

if [[ !("$SRC" =~ ^python3|xbps|npm|cargo$) ]]; then
    show_help
    die "SRC cannot be \"$SRC\". Must be \"python3\", \"xbps\", \"npm\", or \"cargo\"."
fi

if [ -n "$opt_test" ]; then
    bold "[[Test mode active]]"
fi

# Make comma seperated version of packages for use later
pkgs_commasep=""
for pkg in ${PKGS[@]}; do
    if [ -n "$pkgs_commasep" ]; then
	   pkgs_commasep+=","
    fi
    pkgs_commasep+="$pkg"
done

# Check if state exists
state_dir="$prog_dir/../salt/$opt_env/$NAME"
state_file="$state_dir/init.sls"
pretty_state_file="salt/${opt_env}/${NAME}/init.sls"
if grep "src=${SRC}" "$state_file" ; then
    state_exists=true
elif [ -f "$state_file" ]; then
    die "Sate file \"$state_file\" for state \"$NAME\" exists but doesn't follow the format this tool expects. Any actions past this point may be unreliable, exiting."
fi

pillar_dir="$prog_dir/../pillar/$opt_env/$NAME"
pillar_file="$pillar_dir/init.sls"
pretty_pillar_file="pillar/${opt_env}/${NAME}/init.sls"
if grep "${SRC}_${NAME_UNDERSCORED}:" "$pillar_file"; then
    state_exists=true
elif [ -f "$pillar_file" ]; then
    die "Pillar file \"$pillar_file\" for state \"$NAME\" exists but doesn't follow the format this tool expects. Any actions past this point may be unreliable, exiting."
fi

# Exit if state exists and not in force mode
if [ -n "$state_exists" ] && [ -z "$opt_force" ]; then
    die "State \"$NAME\" already exists, pass -f option to append new pillar and state data onto the existing files"
fi

# If in test mode change state and pillar file variables so we don't actually write
# to any files
state_file=/dev/fd/1
pretty_state_file+=" [[no changes made, in test mode]]"

pillar_file=/dev/fd/1
pretty_pillar_file+=" [[no changes made, in test mode]]"

# Create state
for dir in "$state_dir" "$pillar_dir"; do
    mkdir -p "$dir"
    check "Failed to make directory \"$dir\""
done

echo "# Installs $pkgs_commasep from $SRC." >> "$state_file"
check "Failed to add header to state file \"$state_file\""

case "$SRC" in
    python3)
	   cat <<EOF >> "$state_file"
{% for pkg in pillar['$NAME_UNDERSCORED']['pkgs'] %}
{{ pkg }}:
  pip.installed:
    - pip_bin: {{ pillar.python.pip3_bin }}
{% endfor %}
EOF
	   check "Failed to create state file \"$state_file\""
	   ;;
    xbps)
	   cat <<EOF >> "$state_file"
{% for pkg in pillar['$NAME_UNDERSCORED']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
EOF
	   check "Failed to create state file \"$state_file\""
	   ;;
    npm)
	   cat <<EOF >> "$state_file"
{% for pkg in pillar['$NAME_UNDERSCORED']['pkgs'] %}
{{ pkg }}:
  npm.installed
{% endfor %}
EOF
	   ;;
    cargo)
	   cat <<EOF >> "$state_file"
# Install for all users
{% for _, user in pillar['users']['users'].items() %}
  {% for pkg in pillar['$NAME_UNDERSCORED']['pkgs'] %}
    install_cargo_${pkg}_for_{{ user.name }}:
	 cmd.run:
	   - name: {{ pillar.rust.cargo_bin_substitute_path }}/cargo install {{ pkg }}
	   - runas: {{ user.name }}
	   - unless: test -f {{ pillar.rust.cargo_bin_substitute_path }}/{{ pkg }}
  {% endfor %}
{% endfor %}
EOF
	   ;;
esac

bold "Created state file \"$pretty_state_file\""

if [ -z "$state_exists" ]; then # Only start new object if we don't see an existing state.
    echo "$NAME_UNDERSCORED:" >> "$pillar_file"
    check "Failed to create pillar file \"$pillar_file\""
fi

echo "pkgs:" >> "$pillar_file"
check "Failed to create pillar file \"$pillar_file\""

for pkg in ${PKGS[@]}; do
    echo "    - $pkg" >> "$pillar_file"
    check "Failed to create pillar file \"$pillar_file\""
done

bold "Created pillar file \"$pretty_pillar_file\""

bold "Created state \"$NAME\" which installs \"${PKG[@]}\" from \"$SRC\""
