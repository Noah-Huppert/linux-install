# Dict of users objects which configure users
#
# Objects have the following keys:
#
#   - name (String): Login
#   - id (Integer): UID and GID
#   - password_hash (String): SHA 512 password hash, generate with `openssl passwd -6`
#   - ssh_key_name (String, Optional): Name of SSH key in the 
#       salt://users-secret/keys/NAME/ directory without a file extension
#   - groups (String list, Optional): List of keys from groups dict in this
#       pillar which indicate the groups to which a user belongs

users:
  # Name of directory in which to place Zsh profile files 
  zsh_profiles_dir: .zprofile.d

  # Script to "bake" Zsh profiles
  bake_zsh_profiles_script: /opt/bake-zprofiles/bake-zprofiles.sh

  # Path to Zsh shell
  zsh_shell: /bin/zsh

  # Groups
  groups:
    linux_install:
      name: linux-install
      id: 10000

  # Users
  users:
    noah:
      name: noah
      id: 1000
      ssh_key_name: id_ed25519
      groups:
        - linux_install
    root:
      name: root
      id: 0
