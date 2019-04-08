# Install and configure Docker

# Install
{{ pillar.docker.pkg }}:
  pkg.latest

# Enable service
{{ pillar.docker.service }}-enabled:
  service.enabled:
    - name: {{ pillar.docker.service }}
    - require:
      - pkg: {{ pillar.docker.pkg }}

{{ pillar.docker.service }}-running:
  service.running:
    - name: {{ pillar.docker.service }}
    - require:
      - service: {{ pillar.docker.service }}-enabled
