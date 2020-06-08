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
  #     - bin (required): Name of binary which will be present if the package
  #                       is installed.
  #     - repository (required): Name of directory in hostdir/binpkgs which
  #                              contains XBPS file for pkg.
  pkgs:
    zoom:
      bin: zoom
      repository: nonfree
    discord:
      bin: Discord
      repository: nonfree
