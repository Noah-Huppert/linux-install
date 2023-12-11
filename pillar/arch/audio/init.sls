audio:
  # Audio packages to install
  pkgs:
    # Base audio functionality
    - pipewire
    - pipewire-audio
    - pipewire-pulse
    # - pipewire-alsa
    - wireplumber
    - pipewire-jack
    
    # Settings GUI
    - qpwgraph
    - pavucontrol

  # Audio control services
  services: []

  user_services: []
    # - xdg-desktop-portal
    # - pipewire.socket
    # - pipewire-pulse.socket
    # - wireplumber.service
    # - pipewire.service
