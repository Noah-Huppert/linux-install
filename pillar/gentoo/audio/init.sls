audio:
  # Audio packages to install
  pkgs:
    # Base audio functionality
    - media-sound/pulseaudio
    - media-libs/libpulse
    - media-video/pipewire
    - media-video/wireplumber

    # Required by wireplumber to alter scheduling priority
    - sys-auth/rtkit

  # Audio control services
  services: []

  user_services:
    - xdg-desktop-portal
    - pipewire.socket
    - pipewire-pulse.socket
    - wireplumber.service
    - pipewire.service
