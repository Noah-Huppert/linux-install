#!/usr/bin/env bash
#?
# bake-zprofiles.sh - Combine Zsh profile files into 1 larger .zshrc file
#
# USAGE
#
#	bake-zprofiles.sh
#
# BEHAVIOR
#
#	Combines the current user's Zsh profiles into 1 larger file .zshrc file
#
#?

# {{{1 Exit on any error
set -e

# {{{1 Configuration
zshrc_file="$HOME/.zshrc"

# {{{1 Helpers
function die() {
	echo "Error: $@" >&2
	exit 1
}

# {{{1 Clear old .zshrc
if ! echo "" > "$zshrc_file"; then
	die "Failed to clear old .zshrc"
fi

# {{{1 Place zsh profiles into functions
profile_names=()

while read -r zsh_profile_file; do
	# {{{2 Get name of profile which we can use as a function
	profile_name=$(basename "$zsh_profile_file" | awk -F '.' '{ print $1 }')
	profile_names+=("$profile_name")

	# {{{2 Place profile into function
	echo "" >> "$zshrc_file"
	echo "#" >> "$zshrc_file"
	echo "# $zsh_profile_file" >> "$zshrc_file"
	echo "#" >> "$zshrc_file"

	echo "function $profile_name() {" >> "$zshrc_file"

	if ! cat "$HOME/.zprofile.d/$zsh_profile_file" | sed 's/^/    /g' >> "$zshrc_file"; then
		die "Failed to bake $zsh_profile_file"
	fi

	echo "}" >> "$zshrc_file"
done <<< $(ls "$HOME/.zprofile.d" | sort)

# {{{1 Call functions
# {{{2 Documentation notes
echo "" >> "$zshrc_file"
echo "#" >> "$zshrc_file"
echo "# Call zsh unit functions" >> "$zshrc_file"
echo "#" >> "$zshrc_file"

for profile_name in "${profile_names}"; do
	# {{{2 Documentation notes
	echo "" >> "$zshrc_file"
	echo "# ... $profile_name" >> "$zshrc_file"

	# {{{2 Set zsh_unit meta variable
	echo "zsh_unit=\"$profile_name\"" >> "$zshrc_file"

	# {{{2 Call function and handle errors
	echo "if ! $profile_name; then" >> "$zshrc_file"
	echo "    echo \"Error: failed to run \\\"$profile_name\\\" unit\" >&2" >> "$zshrc_file"
	echo "    return 1" >> "$zshrc_file"
	echo "fi" >> "$zshrc_file"
done

# {{{1 Set correct permissions
if ! chmod 600 "$zshrc_file"; then
	die "Failed to chmod zsh profile"
fi
