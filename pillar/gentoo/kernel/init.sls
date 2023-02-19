{% set version = "6.1.11" %}

kernel:
  # Directory where source code lives
  src_dir: /usr/src

  # Directory where current Linux version should be linked
  main_dir: /usr/src/linux

  # Make configuration file location
  make_config_paths:
    - /usr/src/linux/.config
    - /etc/kernels/kernel-config-{{ version }}-gentoo-x86_64


  # The source package name
  src_pkg: sys-kernel/gentoo-sources

  # Current version
  version: {{ version }}