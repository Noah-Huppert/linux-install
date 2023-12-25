# Installs Kitty terminal emulator

kitty_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.kitty.pkgs }}
