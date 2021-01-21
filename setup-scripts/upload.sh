#!/usr/bin/env bash

# Helpers
prog_dir=$(dirname $(realpath "$0"))

check() {
    if [[ "$?" != "0" ]]; then
	   die "$@"
    fi
}

bold() {
    echo "$(tput bold)$@$(tput sgr0)"
}

die() {
    echo "Error: $@" >&2
    exit 1
}

# Options
while getopts "h" opt; do
    case "$opt" in
	   h)
		  cat <<EOF
upload.sh - Upload this local repository to a server.

USAGE

    upload.sh [-h] ADDR [DIR]

ARGUMENTS

    ADDR    Remove server address, accepts SSH shortcuts.
    DIR     (Optional) Directory on remote server to
            upload, defaults to "/etc/linux-install".

OPTIONS

    -h    Show help text.

BEHAVIOR

    Upload the local copy of this repository to a remote
    server using rsync, falls back to using scp.

EOF
		  exit 0
		  ;;
	   '?') die "Unknown option" ;;
    esac
done

shift $((OPTIND-1))

# Arguments
ADDR="$1"
shift

DIR="$1"
shift

if [ -z "$ADDR" ]; then
    die "ADDR argument required"
fi

if [ -z "$DIR" ]; then
    DIR="/etc/linux-install"
fi

# Check for rsync
for bin in rsync scp; do
    if ! which "$bin" &> /dev/null; then
	   die "$bin must be installed"
    fi
done

# Upload
upload_dir=$(realpath "$prog_dir/..")
check "Failed to resolve upload directory"

do_upload() { # ( UPLOAD_PROG )
    UPLOAD_PROG="$1"
    shift
    
    upload_cmd="$UPLOAD_PROG -r $upload_dir ${ADDR}:${DIR}"
    echo "$upload_cmd"
    
    $upload_cmd
}

bold "Uploading"
if ! do_upload rsync; then
    bold "Failed to use rsync, falling back to scp"
    do_upload scp
    check "Failed to upload"
fi
