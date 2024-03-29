{% set version = '12.2.0' %}
{% set dir = '/opt/yay' %}

{% import_yaml 'salt-configuration/init.sls' as salt_config %}

yay:
  aux_pkgs:
    # Required as a tool during build time for packages
    - fakeroot
  
  download:
    url: https://github.com/Jguer/yay/releases/download/v{{ version }}/yay_{{ version }}_x86_64.tar.gz
    sha: 57a69ffe3259173acb2b28603301e23519b9770b0041d63fe716562b6b6be91e
    dir: {{ dir }}

  link:
    target: /usr/local/bin/yay
    source: {{ dir }}/yay_{{ version }}_x86_64/yay
