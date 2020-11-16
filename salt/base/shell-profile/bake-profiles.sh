#!/usr/bin/env bash
#?
# bake-profiles.sh - Combine Shell profile files into 1 larger shell profile file
#
# USAGE
#
#	bake-profiles.sh
#
# BEHAVIOR
#
#	Combines the current user's Shell profiles into 1 larger file shell profile file.
#
#?

# Exit on any error
set -e

# Configuration
profile_file="$HOME/.profile"

# Helpers
function die() {
	echo "Error: $@" >&2
	exit 1
}

# Clear old shell profile file
if ! echo "" > "$profile_file"; then
	die "Failed to clear old shell profile file"
fi

# Place shell profiles into functions
profile_names=()

while read -r shell_profile_file; do
	# Get name of profile which we can use as a function
	profile_name=$(basename "$shell_profile_file" | awk -F '.' '{ print $1 }')
	profile_names+=("$profile_name")

	# Place profile into function
	echo "" >> "$profile_file"
	echo "#" >> "$profile_file"
	echo "# $shell_profile_file" >> "$profile_file"
	echo "#" >> "$profile_file"

	echo "function shell_unit_$profile_name() {" >> "$profile_file"

	if ! cat "$HOME/.profile.d/$shell_profile_file" | sed 's/^/    /g' >> "$profile_file"; then
		die "Failed to bake $shell_profile_file"
	fi

	echo "}" >> "$profile_file"

    	echo "Added \"$shell_profile_file\" to \"$profile_file\""
done <<< $(cat "$HOME/{{ pillar.shell_profile.units_file }}")

# Call functions
# Documentation notes
echo "" >> "$profile_file"
echo "#" >> "$profile_file"
echo "# Call shell unit functions" >> "$profile_file"
echo "#" >> "$profile_file"

echo "for profile_name in ${profile_names[@]}; do" >> "$profile_file"
echo '    shell_unit="$profile_name"' >> "$profile_file"
echo '    if ! shell_unit_$profile_name; then' >> "$profile_file"
echo '        echo "Error: failed to run \"$profile_name\" shell unit" >&2' >> "$profile_file"
echo "    fi" >> "$profile_file"
echo "done" >> "$profile_file"

# Set correct permissions
if ! chmod 600 "$profile_file"; then
	die "Failed to chmod shell profile"
fi

echo "DONE"
