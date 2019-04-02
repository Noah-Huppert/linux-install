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

# File which we record already added keys inside of
added_ssh_keys_file="{{ pillar.users.added_keys_parent_directory }}/$USER/ssh"

# Check if fingerprint of each key is in the file
while read key_file; do
	# Get fingerprint
	key_fingerprint=$(ssh-keygen -lf "$key_file" | awk '{ print $2 }' | awk -F ':' '{ print $2 }')

	if [[ "$?" != "0" ]]; then
		echo "Error: unit: ssh_add: Failed to get \"$key_file\" SSH key fingerprint" >&2
		return 1
	fi

	# If added, skip
	if [ -f "$added_ssh_keys_file" ]; then
		if cat "$added_ssh_keys_file" | grep "$key_fingerprint" &> /dev/null; then
			continue
		fi
	fi

	# Add
	echo "unit: ssh_add: Adding \"$key_file\" SSH private key to ssh-agent (May be prompted for password)"

	if ! ssh-add "$key_file"; then
		echo "Error: unit: ssh_add: Failed to add \"$key_file\" SSH private key to ssh-agent" >&2
		return 1
	fi

	# Record we added it
	if ! echo "$key_fingerprint" >> "$added_ssh_keys_file"; then
		echo "Error: unit: ssh_add: Failed to record that \"$key_file\" key was added to the SSH agent" >&2
		return 1
	fi
done <<< "$ssh_keys"
