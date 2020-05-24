{% set dir = '/opt/void-packages' %}

manual_void_pkgs:
  # Directory to clone into
  clone_dir: {{ dir }}

  # URL of repostory
  clone_url: https://github.com/void-linux/void-packages.git

  # XBPS src configuration file
  config_file: {{ dir }}/etc/conf

  # Custom packages to install.
  # Keys are package names. Values are dicts with the keys:
  #     - repository (required): Name of directory in hostdir/binpkgs which
  #                              contains XBPS file for pkg.
  pkgs:
    zoom:
      repository: nonfree
    discord:
      repository: nonfree
