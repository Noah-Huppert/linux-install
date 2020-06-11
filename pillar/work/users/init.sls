users:
  # Path to Zsh shell
  zsh_shell: /bin/zsh

  # Groups configuration, dict of group objects with the keys:
  #
  #   - name (String): Name
  #   - id (Integer): ID
  groups:
    __: overwrite
    linux_install:
      name: linux-install
      id: 10000
    wheel:
      name: wheel
      id: 10001
    vboxsf:
      name: vboxsf
      id: 998

  # Users configuration, dict of user objects with the keys:
  #
  #   - name (String): Login
  #   - id (Integer): UID and GID
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
      groups:
        - __: overwrite
        - linux_install
        - wheel
        - vboxsf
    root:
      name: root
      id: 0
      home: /root
