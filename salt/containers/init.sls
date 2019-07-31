# Installs and configures podman

{{ pillar.containers.pkg }}:
  pkg.latest

{{ pillar.containers.registries_cfg_file }}:
  file.managed:
    - source: salt://containers/registries.conf
    - mode: 644
