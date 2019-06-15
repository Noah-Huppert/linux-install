{% set version = '5.0.21_1' %}

kernel:
  # Kernel package
  kernel_pkg: linux5.0

  # Old kernel package versions which should be uninstalled
  old_pkgs:
    - linux4.20
    - linux4.20-headers

  # Kernel package version
  version: {{ version }}
