# Install dig

dig_install:
  pkg.installed:
    - pkgs: {{ pillar.dig.pkgs }}