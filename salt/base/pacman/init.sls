# Configures Pacman
{{ pillar.pacman.conf_file }}:
  file.managed:
    - source: salt://pacman/pacman.conf

{{ pillar.pacman.mirrorlist_file }}:
  file.managed:
    - source: salt://pacman/mirrorlist
