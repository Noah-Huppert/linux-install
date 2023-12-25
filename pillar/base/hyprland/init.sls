{% set scripts_dir = '/opt/hyprland-scripts' %}
hyprland:
  # Packages to install through the main package manager
  pkgs: []

  # Packages to install through an alternative package manager
  aux_pkgs: []

  # Name of Salt state to use as alternative package manager
  aux_pkgs_state: pkg

  # Hyprland configuration file location relative to home directory
  hyprland_config_file: .config/hypr/hyprland.conf

  # Hyperpaper configuration file location relative to home directory
  hyprpaper_config_file: .config/hypr/hyprpaper.conf

  # Directory in which supporting scripts (for stuff like bars) will be placed
  scripts_dir: {{ scripts_dir }}

  # Programs to run
  bins:    
    # Terminal program
    terminal: kitty

    # Lists programs to then run
    app_launcher: wofi --show drun

    # Status bar
    status_bar: {{ scripts_dir }}/nwg-panel.sh

    # Bottom dock
    dock: nwg-dock-hyprland -d

    # Background picture renderer
    background: hyprpaper
