{% set scripts_dir = '/opt/i3/scripts' %}

i3:
  # i3 related packages
  pkgs: []

  scripts_dir: {{ scripts_dir }}

  # Config files
  config_files:
    # i3
    - source: salt://i3/conf/i3.conf
      destination: .config/i3/config

    # Polybar
    - source: salt://i3/conf/polybar.ini
      destination: .config/polybar/config.ini

  # Programs to run
  bins:
    # Terminal program
    terminal: kitty

    # Screenshot program
    screenshot: zsh -c 'scrot ~/pictures/screenshots/%Y-%m-%d-%H:%M:%S.png'

    # List programs to then run
    app_launcher: rofi -show run

    # Background
    background: feh

    # Script to make caps lock a control key
    setup_keyboard: {{ scripts_dir }}/setup-keyboard.sh

    # Top status bar
    top_bar: {{ scripts_dir }}/polybar.sh
