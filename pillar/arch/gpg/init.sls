gpg:
  pkgs:
    - pinentry
    - gcr # Dependency of pinentry gnome

  agent_config_opts:
    pinentry-program: /usr/bin/pinentry-gnome3
