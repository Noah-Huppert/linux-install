{% set dir = '/home/noah/bin/particle-cli' %}
particle:
  cli:
    repo: git@github.com:Noah-Huppert/particle-cli-container.git
    dir: {{ dir }}
    link:
      name: /home/noah/bin/particle
      target: {{ dir }}/bin/particle
  lib:
    repo: https://github.com/particle-iot/device-os.git
    target: /home/noah/libs/particle-os
    branch: release/stable
    dep_pkgs:
      - perl-Archive-Zip
