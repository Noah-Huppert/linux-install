wayland:
  pkgs:
    # Base wayland
    - dev-libs/wayland

    # X11 server implemented using Wayland
    - x11-base/xwayland

    # XDG
    - gui-libs/xdg-desktop-portal-wlr

    # Clipboard CLI
    - gui-apps/wl-clipboard

    # Used to test what is running in XWayland
    - x11-apps/xeyes