{% set desktop_file = 'firefox-wayland.desktop' %}

firefox:
  # Desktop file entry for Wayland
  desktop_file: {{ desktop_file }}
  wayland_desktop_file: /usr/local/share/applications/{{ desktop_file }}

  # Command to run Firefox using Wayland
  # MOZ_ENABLE_WAYLAND=1 to force Firefox to use Wayland
  # MOZ_DBUS_REMOTE=1 to make Firefox use already running
  #   instances of itself if available (prevents the
  #   ~"already running" error).
  wayland_cmd: env MOZ_ENABLE_WAYLAND=1 MOZ_DBUS_REMOTE=1 firefox %u
  
  # Packages
  pkgs: []
