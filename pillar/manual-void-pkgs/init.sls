{% set dir = '/opt/void-packages' %}

manual_void_pkgs:
  clone_dir: {{ dir }}
  clone_url: https://github.com/void-linux/void-packages.git
  config_file: {{ dir }}/etc/conf
  pkgs:
    zoom:
      repository: nonfree
