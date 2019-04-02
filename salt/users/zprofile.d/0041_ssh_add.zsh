# Add user's SSH key to ssh-agent if it hasn't been already

# Check if user's SSH keys exist in ~/.ssh directory
ssh_keys=$(find "$HOME/.ssh" -type f ! -name "*.*" -name "id_*")

if [[ "$?" != "0" ]]; then
	echo "Error: unit: ssh_add: Failed to find SSH private key files" >&2
	return 1
fi

if [ -z "$ssh_keys" ]; then # Doesn't exist
	return 0
fi

# Get names of keys added to ssh-agent
added_ssh_keys=$(ssh-add -L 2>&1)

if [[ "$?" != "0" ]]; then
	if [[ "$added_ssh_keys" == "The agent has no identities." ]]; then
		added_ssh_keys=""
	else
		echo "Error: unit: ssh_add: Failed to get names of SSH private keys added to ssh-agent" >&2
		return 1
	fi
fi

# Check if added to ssh-agent
while read key_file; do
	# Get public key 
	public_key=$(cat "$key_file.pub")
	if [[ "$?" != "0" ]]; then
		echo "Error: unit: ssh_add: Failed to get public key contents for \"$key_file\"" >&2
		return 1
	fi

	if echo "$added_ssh_keys" | grep "$public_key" &> /dev/null; then # Already added
		continue
	fi

	echo "unit: ssh_add: Adding \"$key_file\" SSH private key to ssh-agent (May be prompted for password)"

	if ! ssh-add "$key_file"; then
		echo "Error: unit: ssh_add: Failed to add \"$key_file\" SSH private key to ssh-agent" >&2
		return 1
	fi
done <<< "$ssh_keys"
