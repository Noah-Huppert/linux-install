sway:
  # Sway configuration file relative to $HOME
  sway_config_file: .config/sway/config

  # Waybar configuration file
  waybar_config_file: .config/waybar/config
  waybar_style_file: .config/waybar/style.css

  waybar_org_clock_script: .config/waybar/custom-org-clock.sh
    

  # Swaynag configuration file
  swaynag_config_file: .config/swaynag/config

  # Exit script
  swayexit_file: /usr/local/bin/swayexit

  # Screenshot script
  wl_snip_file: /usr/local/bin/wl-snip
  
  xbps_sway_pkgs:
    # Compositor
    - sway

    # Launch menu
    # - bemenu # Now using sway-launcher-desktop

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
