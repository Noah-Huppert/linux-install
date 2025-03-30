#!/usr/bin/env bash
set -e

PROG_DIR=$(realpath $(dirname "$0"))

die () { # (msg)
    msg="$1"
    echo "Error: $1" >&2
    exit 1
}

# Options
ENV=""
while getopts "he:" opt; do
    case "$opt" in
        h)
            cat <<EOF
scaffold_multipkg_state.sh - Create files and directories to install a package via the multipkg module

USAGE

    scaffold_multipkg_state.sh [-h] [-e ENV] NAME

OPTIONS

    -h        Show this help text and exit
    -e ENV    Name of pillar ENV in which to create additional pillar file

ARGUMENTS

    NAME    Name of state (alphanumeric or dashes, cannot start or end with dash)
    DESC    Description of what package will be installed (put as comment at top of state dir)

BEHAVIOR

    Creates a state in the base environment which installs packages specified by the pillar. If the ENV option is provided also creates a pillar file for that env.

EOF
            exit 0
            ;;
        e) ENV="$OPTARG" ;;
        '?') die "Unknown option" ;;
    esac
done

shift $((OPTIND-1))

# Arguments
NAME="$1"
DESC="$2"
if [[ -z "$NAME" ]]; then
    die "NAME argument must be provided"
fi

if [[ $NAME =~ ^[a-z0-9][a-z-0-9]*[a-z0-9]$ ]]; then
    die "NAME argument can only contain lowercase numbers, letters, or dashes (May not start or end with a dash)"
fi

if [[ -z "$DESC" ]]; then
    die "DESC argument must be provided"
fi

# Make directories
salt_base_dir="$PROG_DIR/../salt/base/$NAME"
pillar_base_dir="$PROG_DIR/../pillar/base/$NAME"
pillar_env_dir="$PROG_DIR/../pillar/$ENV/$NAME"

mkdir -p "$salt_base_dir"
mkdir -p "$pillar_base_dir"

if [[ -n "$ENV" ]]; then
    mkdir -p "$pillar_env_dir"
else
    pillar_env_dir=""
fi

# Fill in files
cat <<EOF | tee "$salt_base_dir"
# Installs $DESC
$NAME_pkgs:
  multipkg.installed:
    - pkgs: {{ pillar.${NAME}.multipkgs }}
EOF

cat <<EOF | tee "$pillar_base_dir" "$pillar_env_dir"
${NAME}:
  multipkgs: []
EOF
