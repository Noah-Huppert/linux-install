#!/usr/bin/env bash
#?
# check-refind-installed.sh - Check refind is installed
#
# USAGE
#
#	check-refind-installed.sh OPTIONS
#
# OPTIONS
#
#	-p REFIND_PATH    Path to Refind directory
#
# BEHAVIOR
#
#	Exits with code 0 if refind is installed.
#
#	Exit with code 1 if refind is not installed.
#
#?

# {{{1 Exit on any error
set -e

# {{{1 Helpers
function die() {
	echo "Error: $@" >&2
	exit 1
}

# {{{1 Options
# {{{2 Get
while getopts "p:" opt; do
	case "$opt" in
		p) refind_path="$OPTARG" ;;
		'?') die "Unknown option" ;;
	esac
done

# {{{2 Verify
# {{{3 refind_path
if [ -z "$refind_path" ]; then
	die "-p REFIND_PATH option required"
fi

if [ -e "$refind_path" ]; then
	exit 0
else
	exit 1
fi
