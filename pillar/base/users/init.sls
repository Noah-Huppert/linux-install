users:
  # Path to user's shell
  shell: /usr/bin/bash

  # Directory which keeps track of which keys have been added for a user.
  # This directory will have a sub-directory for each user where the shell 
  # profile can put state files.
  added_keys_parent_directory: /var/added-user-keys

  # Groups configuration, dict of group objects with the keys:
  #
  #   - name (String): Name
  #   - id (Integer, Optional): ID
  groups:
    linux_install:
      name: linux-install
      id: 10000

  # Users configuration, dict of user objects with the keys:
  #
  #   - name (String): Login
  #   - id (Integer): UID and GID
  #   - home (String): Home directory
  #   - password_hash (String): SHA 512 password hash, generate with 
  #       the `openssl passwd -6` command. These keys are stored in the 
  #       users-secret pillar
  #   - ssh_key_name (String, Optional): Name of SSH key in the 
  #       salt://users-secret/keys/NAME/ directory without a file extension
  #   - groups (String list, Optional): List of keys from groups dict in this
  #       pillar which indicate the groups to which a user belongs
  users:
    noah:
      name: noah
      id: 1000
      home: /home/noah
      ssh_key_name: id_ed25519
      groups: {}
    root:
      name: root
      id: 0
      home: /root
