{% set scripts_dir = '/opt/hyprland/scripts' %}
{% set lock_background_path = '/opt/hyprland/lock-background.jpg' %}
{% set shutdown_menu_config = '.config/nwg-bar/bar.json' %}

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

    # Waybar config
    - source: salt://hyprland/conf/waybar.json
      destination: .config/waybar/config

    - source: salt://hyprland/conf/waybar.css
      destination: .config/waybar/style.css

    # NWG Bar (shutdown menu) config
    - source: salt://hyprland/conf/nwg-bar.json
      destination: {{ shutdown_menu_config }}

    - source: salt://hyprland/conf/nwg-bar.css
      destination: .config/nwg-bar/style.css

  # Directory in which supporting scripts (for stuff like bars) will be placed
  scripts_dir: {{ scripts_dir }}

  # Directory in which extra icons will be stored
  icons_dir: /opt/hyprland/icons

  # Path to synlink which should hold current lock background file
  lock_background_path: {{ lock_background_path }}

  # Programs to run
  bins:    
    # Terminal program
    terminal: kitty

    # Notification daemon
    notification_daemon: swaync

    # Lists programs to then run
    app_launcher: {{ scripts_dir }}/nwg-drawer.sh launch

    # Command to run when first started so launcher is ready to go
    # If null nothing is run
    app_launcher_preload_cmd: {{ scripts_dir }}/nwg-drawer.sh preload

    # Status bar
    status_bar: {{ scripts_dir }}/status-bar.sh

    # Bottom dock
    dock: nwg-dock-hyprland -d

    # Background picture renderer
    background: {{ scripts_dir }}/hyprpaper.sh

    # Screenshot program
    screenshot: wl-snip -n notify-send

    # Network manager
    network_menu: nm-applet

    # Bluetooth manager
    bluetooth_menu: blueman-applet

    # Volume manager
    volume: pavucontrol

    # Open menu with shutdown options
    shutdown_menu: nwg-bar -t $HOME/{{ shutdown_menu_config }}

    # Lock command:
    lock: swaylock -f --image {{ lock_background_path }}

    # Sleep command
    sleep: systemctl suspend

    # Hibernate command
    hibernate: systemctl hibernate

    # Logout command
    logout: hyprctl dispatch exit


    # Reboot command
    reboot: systemctl reboot

    # Shutdown command
    shutdown: systemctl -i poweroff
