firefox:
  # Desktop file entry for Wayland
  wayland_desktop_file: /usr/local/share/applications/firefox-wayland.desktop
  
  # Packages
  pkgs:
    - firefox
    
    # Allows firefox to be controlled via a script
    - geckodriver
    
    # Package which provides MP4 codec to firefox
    - gst-libav
