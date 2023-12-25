{% set scripts_dir = '/opt/hyprland-scripts' %}
hyprland:
  # Packages to install through the main package manager
  pkgs: []

  # Packages to install through an alternative package manager
  aux_pkgs: []

  # Name of Salt state to use as alternative package manager
  aux_pkgs_state: pkg

  # Configuration files
  config_files:
    # Hyprland configuration
    - source: salt://hyprland/conf/hyprland.conf
      destination: .config/hypr/hyprland.conf

    # Hyprpaper configuration
    - source: salt://hyprland/conf/hyprpaper.conf
      destination: .config/hypr/hyprpaper.conf

    # nwg-panel
    - source: salt://hyprland/conf/nwg-panel.json
      destination: .config/nwg-panel/config
    
    - source: salt://hyprland/conf/nwg-panel.css
      destination: .config/nwg-panel/style.css

    # nwg-drawer styles
    - source: salt://hyprland/conf/nwg-drawer.css
      destination: .config/nwg-drawer/drawer.css

  # Directory in which supporting scripts (for stuff like bars) will be placed
  scripts_dir: {{ scripts_dir }}

  # Programs to run
  bins:    
    # Terminal program
    terminal: kitty

    # Lists programs to then run
    app_launcher: {{ scripts_dir }}/nwg-drawer.sh launch

    # Command to run when first started so launcher is ready to go
    # If null nothing is run
    app_launcher_preload_cmd: {{ scripts_dir }}/nwg-drawer.sh preload

    # Status bar
    status_bar: {{ scripts_dir }}/nwg-panel.sh

    # Bottom dock
    dock: nwg-dock-hyprland -d

    # Background picture renderer
    background: {{ scripts_dir }}/hyprpaper.sh
