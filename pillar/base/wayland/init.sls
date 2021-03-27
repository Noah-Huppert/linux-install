  wayland:
    xbps_wayland_pkgs:
      # Base Wayland implementation
      - wayland

      # X11 server implemented using Wayland
      - weston-xwayland

      # Clipboard command line utilities
      - wl-clipboard
      
      # Screen sharing
      - xdg-desktop-portal-wlr
      - pipewire
