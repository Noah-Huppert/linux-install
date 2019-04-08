{% set version = '5.0.7_1' %}

kernel:
  # Name of linux package without version
  pkg: linux5.0

  # Old kernel package versions which should be uninstalled
  old_pkgs:
    - linux4.20

  # Kernel package version
  version: {{ version }}
