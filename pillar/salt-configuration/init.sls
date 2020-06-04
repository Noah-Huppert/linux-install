salt_configuration:
  # Salt minion configuration file:
  minion_config_file: /etc/salt/minion

  # Salt environment
  environment: base

  # State directories
  state_dirs:
    # Base environment
    base:
      # Public state directory
      public: /srv/salt

      # Secret state directory
      secret: /srv/salt-secret

    # Work environment
    work:
      public: /srv/salt/work

  # Pillar directories
  pillar_dirs:
    # Base environment
    base:
      # Public pillar directory
      public: /srv/pillar

      # Secret pillar directory
      secret: /srv/pillar-secret

    # Work environment
    work:
      public: /srv/pillar/work
