{% set sway_dir = ".config/sway" %}
{% set waybar_dir = ".config/waybar" %}
{% set swaynag_dir = ".config/swaynag" %}

sway:
  # Sway configuration file relative to $HOME
  sway_dir: {{ sway_dir }}
  sway_config_file: {{ sway_dir }}/config

  desktop_portal_script: {{ sway_dir }}/desktop-portal-setup.sh

  # Elogind
  elogind_svc: null

  # Waybar configuration file
  waybar_dir: {{ waybar_dir }}
  waybar_config_file: {{ waybar_dir }}/config
  waybar_style_file: {{ waybar_dir }}/style.css

  waybar_org_clock_script: {{ waybar_dir }}/custom-org-clock.sh
  waybar_xkb_script: {{ waybar_dir }}/custom-xkb.sh

  waybar_modules:
    left: []
    center: []
    right: []
  
  # Swaynag configuration file
  swaynag_dir: {{ swaynag_dir }}
  swaynag_config_file: {{ swaynag_dir }}/config

  # Exit script
  swayexit_file: /usr/local/bin/swayexit

  # Screenshot script
  wl_snip_file: /usr/local/bin/wl-snip

  # Program used to list and execute programs
  app_launcher: rofi -show drun

  pkgs: []
