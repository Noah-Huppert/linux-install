{% set sway_dir = ".config/sway" %}
{% set waybar_dir = ".config/waybar" %}
{% set swaynag_dir = ".config/swaynag" %}

sway:
  # Sway configuration file relative to $HOME
  sway_dir: {{ sway_dir }}
  sway_config_file: {{ sway_dir }}/config

  # Elogind
  elogind_svc: elogind

  # Waybar configuration file
  waybar_dir: {{ waybar_dir }}
  waybar_config_file: {{ waybar_dir }}/config
  waybar_style_file: {{ waybar_dir }}/style.css

  waybar_org_clock_script: {{ waybar_dir }}/custom-org-clock.sh
  waybar_xkb_script: {{ waybar_dir }}/custom-xkb.sh  
  
  # Swaynag configuration file
  swaynag_dir: {{ swaynag_dir }}
  swaynag_config_file: {{ swaynag_dir }}/config

  # Exit script
  swayexit_file: /usr/local/bin/swayexit

  # Screenshot script
  wl_snip_file: /usr/local/bin/wl-snip

  xbps_sway_pkgs:
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