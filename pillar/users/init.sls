# Dict of users objects which configure users
#
# Objects have the following keys:
#
#   - name: Login
#   - password_hash: SHA 512 password hash, generate with `openssl passwd -6`
#   - ssh_key_name (Optional): Name of SSH key in the 
#                              salt://users-secret/keys/NAME/ directory without
#                              a file extension

users:
  # Name of directory in which to place Zsh profile files 
  zsh_profiles_dir: .zprofile.d

  # Script to "bake" Zsh profiles
  bake_zsh_profiles_script: /opt/bake-zprofiles/bake-zprofiles.sh

  # Users
  users:
    noah:
      name: noah
      ssh_key_name: id_ed25519
    root:
      name: root
