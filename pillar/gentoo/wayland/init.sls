wayland:
  pkgs:
    # Base wayland
    - dev-libs/wayland

    # X11 server implemented using Wayland
    - x11-base/xwayland

    # Clipboard CLI
    - gui-apps/wl-clipboard