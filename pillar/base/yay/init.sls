{% set version = '12.4.2' %}
{% set dir = '/opt/yay' %}

{% import_yaml 'salt-configuration/init.sls' as salt_config %}

yay:
  aux_pkgs:
    # Required to build packages
    - base-devel
    
    # Required as a tool during build time for packages
    - fakeroot
  
  download:
    url: https://github.com/Jguer/yay/releases/download/v{{ version }}/yay_{{ version }}_x86_64.tar.gz
    sha: 1ad3e5dbc410edc668eb9062bb6e56b90da818780581f06aa79dd696aa0b5ceb
    dir: {{ dir }}

  link:
    target: /usr/local/bin/yay
    source: {{ dir }}/yay_{{ version }}_x86_64/yay
