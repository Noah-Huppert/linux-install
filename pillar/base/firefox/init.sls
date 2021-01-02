firefox:
  # Desktop file entry for Wayland
  wayland_desktop_file: /usr/local/share/applications/firefox-wayland.desktop

  # Command to run Firefox using Wayland
  # MOZ_ENABLE_WAYLAND=1 to force Firefox to use Wayland
  # MOZ_DBUS_REMOTE=1 to make Firefox use already running
  #   instances of itself if available (prevents the
  #   ~"already running" error).
  wayland_cmd: env MOZ_ENABLE_WAYLAND=1 MOZ_DBUS_REMOTE=1 firefox
  
  # Packages
  pkgs:
    - firefox
    
    # Allows firefox to be controlled via a script
    - geckodriver
    
    # Package which provides MP4 codec to firefox
    - gst-libav
