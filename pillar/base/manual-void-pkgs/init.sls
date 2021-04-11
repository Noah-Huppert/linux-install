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
  #     - latest_version (required): Newest XBPS package version to expected for
  #                                  package. Cannot be used to specify an older
  #                                  version, just to ensure the newest
  #                                  is installed.
  #     - repository (required): Name of directory in hostdir/binpkgs which
  #                              contains XBPS file for pkg.
  pkgs:
    zoom:
      latest_version: 5.3.469451.0927_1
      repository: nonfree
    discord:
      latest_version: 0.0.14_1
      repository: nonfree

