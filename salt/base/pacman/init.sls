# Configures Pacman
{{ pillar.pacman.conf_file }}:
  file.managed:
    - source: salt://pacman/pacman.conf
