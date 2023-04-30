emacs:
  pkgs:
    # Editor
    - app-editors/emacs

    # Spell check
    - app-text/aspell
    - app-dicts/aspell-en

  users:
    - noah
  
  svc:
    file: .config/systemd/user/emacs.service
