# Import user's GPG keys if they exist

# Configuration
gpg_dir="$HOME/.gnupg"
import_public_file="$gpg_dir/{{ pillar.gpg.import_files.public }}"
import_private_file="$gpg_dir/{{ pillar.gpg.import_files.private }}"
import_trust_file="$gpg_dir/{{ pillar.gpg.import_files.trust }}"

import_files=("$import_public_file" "$import_private_file" "$import_trust_file")

# Check if user has GPG keys
for f in "${import_files[@]}"; do
	if [ ! -f "$f" ]; then
		return 0
	fi
done

# Check if key already imported
if [ -d "$gpg_dir" ] && [ -f "$gpg_dir/pubring.kbx" ] && [ -f "$gpg_dir/trustdb.gpg" ]; then
	private_keys=$(gpg -K)

	if [[ "$?" != "0" ]]; then
		echo "Error: unit: gpg_import: Failed to list GPG private keys" &2
		return 1
	fi

	if [ ! -z "$private_keys" ]; then
		return 0
	fi
fi

# Import
echo "unit: gpg_import: Importing GPG key (May be prompted for private key password)"

echo "OK? [Y/n] "
read check_ok

check_ok=$(echo "$check_ok" | tr '[:upper:]' '[:lower:]')

if [[ "$check_ok" != "y" && "$check_ok" != "" ]]; then
	echo "unit: gpg_import: Won't import"
	return 1
fi

echo "unit: gpg_import: Importing public key"

if ! gpg --import < "$import_public_file"; then
	echo "Error: unit: gpg_import: Failed to import public key" >&2
	return 1
fi

echo "unit: gpg_import: Importing private key"

if ! gpg --import < "$import_private_file"; then
	echo "Error: unit: gpg_import: Failed to import private key" >&2
	return 1
fi

echo "unit: gpg_import: Importing owner trust"

if ! gpg --import-ownertrust < "$import_trust_file"; then
	echo "Error: unit: gpg_import: Failed to import owner trust" >&2
	return 1
fi
