# Installs and configures podman

containers_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.containers.pkgs }}

# Configure podman registries
{% if pillar['containers']['registries_cfg_file'] is not none %}
{{ pillar.containers.registries_cfg_file }}:
  file.managed:
    - source: salt://containers/registries.conf
    - mode: 644
{% endif %}

# Run Docker service
{{ pillar.containers.docker_svc }}-enabled:
  service.enabled:
    - name: {{ pillar.containers.docker_svc }}
    - require:
        - pkg: containers_pkgs

{{ pillar.containers.docker_svc }}-running:
  service.running:
    - name: {{ pillar.containers.docker_svc }}
    - require:
      - service: {{ pillar.containers.docker_svc }}-enabled
