{% set version = '12.3.5' %}
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
    sha: 09b570e649aa7b111305ce1df9a83f0e88b06c191eeb8277aad2ac1ead2cbd6f
    dir: {{ dir }}

  link:
    target: /usr/local/bin/yay
    source: {{ dir }}/yay_{{ version }}_x86_64/yay
