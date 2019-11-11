# Installs a container which runs the Particle CLI

{{ pillar.particle_cli.repo }}:
  git.cloned:
    - user: noah
    - target: {{ pillar.particle_cli.dir }}

{{ pillar.particle_cli.link.name }}:
  file.symlink:
    - target: {{ pillar.particle_cli.link.target }}
