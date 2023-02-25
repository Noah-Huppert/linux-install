sway:
  elogind_svc: elogind

  waybar_modules:
    left:
      - sway/workspaces
      - sway/mode
      - custom/org-clock

    center:
      - wireplumber
      - backlight
      - network

    right:
      - disk
      - battery
      - clock

  pkgs:
    # Compositor
    - sway

    # DBus session manager, sets XDG_RUNTIME_DIR for sway
    - elogind
    - seatd
    - libdri2-git

    # Launch menu
    # - bemenu # Now using sway-launcher-desktop

    # Keyboard
    - xkb-switch
    
    # Locker
    - swaylock

    # Menu bar
    - Waybar
    #- font-awesome

    # To take screenshots
    - slurp
    - grim

    # File browser
    - Thunar

    # Image viewers
    - imv
    - ristretto

    # Polkit agent
    - polkit-gnome