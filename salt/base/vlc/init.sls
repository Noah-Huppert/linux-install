# Installs VLC, a video player application
vlc_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.vlc.pkgs }}
