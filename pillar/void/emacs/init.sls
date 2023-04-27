emacs:
  # Packages
  pkgs:
    - emacs
    - emacs-gtk3
    - ncurses-term # Required so M-x ansi-term works
    - libtool # So vterm can compile itself
    - avfs # dired-avfs - seamless archive browsing

  users:
    - noah

  svc:
    file: .sv/emacs/run
