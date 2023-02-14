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
                unit-echo "No file '$f'"
                return 0
	fi
done

# Check if key already imported
gpg_keys_added_file="{{ pillar.users.added_keys_parent_directory }}/$USER/gpg"

if [ -f "$gpg_keys_added_file" ]; then
	return 0
fi

# Import
unit-echo "Importing GPG key (May be prompted for private key password)"

unit-echo "OK? [Y/n] "
read check_ok

check_ok=$(echo "$check_ok" | tr '[:upper:]' '[:lower:]')

if [[ "$check_ok" != "y" && "$check_ok" != "" ]]; then
	return $(unit-die "Won't import")
fi

unit-echo "Importing public key"

if ! gpg --import < "$import_public_file"; then
	return $(unit-die "Error: unit: gpg_import: Failed to import public key")
fi

unit-echo "Importing private key"

if ! gpg --import < "$import_private_file"; then
	return $(unit-die "Failed to import private key")
fi

unit-echo "Importing owner trust"

if ! gpg --import-ownertrust < "$import_trust_file"; then
	return $(unit-die "Failed to import owner trust")
fi

echo "OK" > "$gpg_keys_added_file"
