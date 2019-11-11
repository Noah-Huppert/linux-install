{% set dir = '/home/noah/bin/particle-cli' %}
particle_cli:
  repo: git@github.com:Noah-Huppert/particle-cli-container.git
  dir: {{ dir }}
  link:
    name: /home/noah/bin/particle
    target: {{ dir }}/bin/particle
