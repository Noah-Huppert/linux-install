salt_configuration:
  # Salt minion configuration file:
  minion_config_file: /etc/salt/minion

  # State directories
  state_dirs:
    # Public state directory
    public: /srv/salt

    # Secret state directory
    secret: /srv/salt-secret

  # Pillar directories
  pillar_dirs:
    # Public pillar directory
    public: /srv/pillar

    # Secret pillar directory
    secret: /srv/pillar-secret
