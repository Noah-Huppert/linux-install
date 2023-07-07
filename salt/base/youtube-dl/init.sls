# Installs Youtube DL

youtube_dl:
  pkg.installed:
    - pkgs: {{ pillar.youtube_dl.pkgs }}
