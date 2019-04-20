audio:
  # Audio packages to install
  pkgs:
    - alsa-utils
    - pulseaudio
    - ConsoleKit2
    - pavucontrol

  # Audio control services
  services:
    - alsa
    - dbus
    - cgmanager
    - consolekit

  # Volume control script
  volume_control_script: /usr/bin/volumectl
