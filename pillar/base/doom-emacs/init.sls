doom_emacs:
  pkgs: []

  repos:
    doom:
      git: https://github.com/hlissner/doom-emacs.git
      branch: master
      home_relative_target: .emacs.d/

    config:
      git: https://github.com/Noah-Huppert/emacs-configuration.git
      branch: doom
      home_relative_target: .config/doom/

