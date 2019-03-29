#!/usr/bin/env bash
#?
# check-refind-installed.sh - Check refind is installed
#
# USAGE
#
#	check-refind-installed.sh
#
# BEHAVIOR
#
#	Exits with code 0 if refind is installed.
#
#	Exit with code 1 if refind is not installed.
#
#?

if [ -e "{{ pillar.partitions.boot.mountpoint }}/refind" ]; then
	exit 0
else
	exit 1
fi
