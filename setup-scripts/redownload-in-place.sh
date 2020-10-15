#!/usr/bin/env bash

# Helpers
prog_dir=$(dirname $(realpath "$0"))

die () {
    echo "Error: $@" >&2
    exit 1
}

check() {
    if [ "$?" -ne 0 ]; then
	   die "$@"
    fi
}

# Configuration
repo_dir=$(realpath "$prog_dir/..")
repo_dir_parent=$(realpath "$repo_dir/..")

backup_dir="$repo_dir_parent/linux-install-old"

main_repo_dl_url=https://github.com/Noah-Huppert/linux-install/archive/master.zip
main_repo_dl_file=/tmp/linux-install-master.zip
main_repo_dl_extracted_dir=/tmp/linux-install-master

secrets_repo_dl_url=https://github.com/Noah-Huppert/linux-install-secrets/archive/master.zip
secrets_repo_dl_file=/tmp/linux-install-secrets-master.zip
secrets_repo_dl_extracted_dir=/tmp/linux-install-secrets-master

# Options
while getopts "h" opt; do
    case "$opt" in
	   h)
		  cat <<EOF
redownload-in-place.sh - Redownload the linux install repository master branch via ZIP files.

USAGE

    redownload-in-place.sh [-h]

OPTIONS

    -h    Show help text.

BEHAVIOR

    Redownload the linux install + secrets repository via ZIP files and replace the current
    contents of the /etc/linux-install directory.

    Useful when setting up an environment and you have fixed a problem on another machine
    and need those new changes.

EOF
		  exit 0
		  ;;
	   '?')
    esac
done

# Move directory to backup location
if [ -f "$backup_dir" ]; then
    die "Will not delete backup of an old linux install directory (probably created by this script) named \"$backup_dir\", please manually remove and try again"
fi

mv "$repo_dir" "$backup_dir"
check "Failed to backup \"$repo_dir\" at \"$backup_dir\""

# Setup a trap to delete temp files on exit and restore backup dir on error
delete_tmp_files() {
    failed=""
    
    for file in "$main_repo_dl_file" "$secrets_repo_dl_file"; do
	   if [ -f "$file" ]; then
		  if ! rm "$file"; then
			 echo "Error: Failed to delete temporary file \"$file\", delete it manually" >&2
			 failed=true
		  fi
	   fi
    done

    if [ -n "$failed" ]; then
	   die "Failed to delete temporary files, see above and delete manually"
    fi
}

restore_backup_dir() {
    if [ "$?" -ne 0 ] && [ -f "$backup_dir" ] && [ ! -f "$repo_dir" ]; then
	   mv "$backup_dir" "$repo_dir"
	   check "After a previous failed to restore backup directory \"$backup_dir\" to \"$repo_dir\""
    fi
}

on_exit_during() {
    delete_tmp_files
    restore_backup_dir
}

trap on_exit_during EXIT

# Ensure there are no uncomitted changing before re-downloading
if which git &> /dev/null && [ -d "$repo_dir" ] && [ -d "$repo_dir/.git" ]; then
    cd "$repo_dir"
    check "Failed to change to the repository directory"

    git_status=$(git status -s)
    check "Failed to get the existing linux install repository's status"
    
    if [ -n "$git_status" ]; then
	   die "Uncomitted changes in the linux install repository, will not delete"
    fi
fi

# Delete the existing repo directory
if [ -f "$repo_dir" ]; then
    rm -rf "$repo_dir"
    check "Failed to delete the repository directory"
fi

# Download main repository and extract
curl -L "$main_repo_dl_url" -o "$main_repo_dl_file"
check "Failed to download main repository"

unzip "$main_repo_dl_file"
check "Failed to unzip the downloaded main repository file"

mv "$main_repo_dl_extracted_dir" "$repo_dir"
check "Failed to move extracted main repository directory to correct location"

# Download screts repository and extract
curl -L "$secrets_repo_dl_url" -o "$secrets_repo_dl_file"
check "Failed to download secrets repository"

unzip "$secrets_repo_dl_file"
check "Failed to unzip the downloaded secrets repository file"

mv "$secrets_repo_dl_extracted_dir" "$repo_dir/secrets"
check "Failed to move extracted secrets repository directory to correct location"

# Done
echo "Success"
