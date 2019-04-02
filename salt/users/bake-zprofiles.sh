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

# {{{1 Helpers
function die() {
	echo "Error: $@" >&2
	exit 1
}

# {{{1 Clear old .zshrc
if ! echo "" > "$HOME/.zshrc"; then
	die "Failed to clear old .zshrc"
fi

# {{{1 Bake
while read -r zsh_profile_file; do
	echo "" >> "$HOME/.zshrc"
	echo "#" >> "$HOME/.zshrc"
	echo "# $zsh_profile_file" >> "$HOME/.zshrc"
	echo "#" >> "$HOME/.zshrc"

	if ! cat "$HOME/.zprofile.d/$zsh_profile_file" >> "$HOME/.zshrc"; then
		die "Failed to bake $zsh_profile_file"
	fi

done <<< $(ls "$HOME/.zprofile.d" | sort)

# {{{1 Set correct permissions
if ! chmod 600 "$HOME/.zshrc"; then
	die "Failed to chmod zsh profile"
fi
