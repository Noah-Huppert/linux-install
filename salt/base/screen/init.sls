# Installs the screen tool
screen_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.screen.pkgs }}
