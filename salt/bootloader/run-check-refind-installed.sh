#!/usr/bin/env bash
#?
# run-check-refind-installed.sh - Run the check-refind-installed.sh script
#
# USAGE
#
#	run-check-refind-installed.sh
#
# BEHAVIOR
#
#	Run the check-refind-installed.sh script with the correct arguments.
#
#?

exec {{ pillar.bootloader.check_refind_installed_script.file }} \
	-p {{ pillar.bootloader.refind.directory }}
