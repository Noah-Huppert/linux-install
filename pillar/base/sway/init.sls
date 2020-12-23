sway:
  # Sway configuration file relative to $HOME
  sway_config_file: .config/sway/config

  # Waybar configuration file
  waybar_config_file: .config/waybar/config
  waybar_style_file: .config/waybar/style.css

  # Exit script
  swayexit_file: /usr/local/bin/swayexit
  
  xbps_sway_pkgs:
    # Compositor
    - sway

    # Launch menu
    - bemenu

    # Locker
    - swaylock

    # Menu bar
    - Waybar
    #- font-awesome
