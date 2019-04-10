# Add user's SSH key to ssh-agent if it hasn't been already

# Check if user's SSH keys exist in ~/.ssh directory
ssh_keys=$(find "$HOME/.ssh" -type f ! -name "*.*" -name "id_*")

if [[ "$?" != "0" ]]; then
	return $(unit-die "Failed to find SSH private key files")
fi

if [ -z "$ssh_keys" ]; then # Doesn't exist
	return 0
fi

# File which we record already added keys inside of
added_public_keys=$(ssh-add -L)
if [[ "$added_public_keys" != "The agent has no identities." && "$?" != "0" ]]; then
    return $(unit-die "Failed to get added keys")
fi

# Check if fingerprint of each key is in the file
while read key_file; do
	# Get public key
	public_key=$(cat "$key_file.pub")

	if [[ "$?" != "0" ]]; then
		return $(unit-die "Failed to get \"$key_file\" public key")
	fi

	# If added, skip
	if echo "$added_public_keys" | grep "$public_key" &> /dev/null; then
	    continue
	fi

	# Tell to add
	unit-echo "run \`ssh-add $key_file\`"
done <<< "$ssh_keys"
