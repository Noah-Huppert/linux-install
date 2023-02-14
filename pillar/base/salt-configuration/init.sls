{% set content_root = '/srv' %}

salt_configuration:
  # Salt minion configuration file:
  minion_config_file: /etc/salt/minion

  # State directories
  state_dirs:
    base:
      public: {{ content_root }}/salt/base
      secret: {{ content_root }}/salt/base-secret
    void:
      public: {{ content_root }}/salt/void
    gentoo:
      public: {{ content_root }}/salt/gentoo
    work:
      public: {{ content_root }}/salt/work
    wsl:
      public: {{ content_root }}/salt/wsl

  # Pillar directories
  pillar_dirs:
    base:
      public: {{ content_root }}/pillar/base
      secret: {{ content_root }}/pillar/base-secret
    void:
      public: {{ content_root }}/pillar/void
    gentoo:
      public: {{ content_root }}/pillar/gentoo
    work:
      public: {{ content_root }}/pillar/work
    wsl:
      public: {{ content_root }}/pillar/wsl

  # Pillar stack configuration files
  pillar_stack:
    base:
      public: {{ content_root }}/pillar/base/pillar-stack.cfg
      secret: {{ content_root }}/pillar/base-secret/pillar-stack.cfg
    void:
      public: {{ content_root }}/pillar/void/pillar-stack.cfg
    gentoo:
      public: {{ content_root }}/pillar/gentoo/pillar-stack.cfg
      secret: {{ content_root }}/pillar/gentoo-secret/pillar-stack.cfg
    work:
      public: {{ content_root }}/pillar/work/pillar-stack.cfg
    wsl:
      public: {{ content_root }}/pillar/wsl/pillar-stack.cfg
