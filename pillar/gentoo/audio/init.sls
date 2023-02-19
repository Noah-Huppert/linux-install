audio:
  # Audio packages to install
  pkgs:
    - media-sound/pulseaudio
    - media-libs/libpulse
    - media-video/pipewire
    - media-video/wireplumber

  # Audio control services
  services: []

  user_services:
    - xdg-desktop-portal
