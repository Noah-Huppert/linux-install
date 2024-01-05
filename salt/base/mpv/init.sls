# Installs MPV, a video player
mpv_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.mpv.pkgs }}
