audio:
  # Audio packages to install
  pkgs:
    - alsa-utils
    - pulseaudio
    - ConsoleKit2

  # Audio control services
  services:
    - alsa
    - dbus
    - cgmanager
    - consolekit