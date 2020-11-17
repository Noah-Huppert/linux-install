emacs:
  # Packages
  pkgs:
    - emacs
    - emacs-gtk3
    - ncurses-term # Required so M-x ansi-term works
    - libtool # So vterm can compile itself

  # Configuration directory
  configuration_directory: /home/noah/.emacs.d

  # Configuration repository
  configuration_repo: git@github.com:Noah-Huppert/emacs-configuration.git

  # Base part of the user specific emacs service. Will be combined with each
  # users name to create unique services.
  base_svc_name: emacs
