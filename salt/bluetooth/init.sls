# Install bluetooth service

# Install
{{ pillar.bluetooth.pkg }}:
  pkg.latest

# Service
{{ pillar.bluetooth.service }}-enabled:
  service.enabled:
    - name: {{ pillar.bluetooth.service }}
    - require:
      - pkg: {{ pillar.bluetooth.pkg }}

{{ pillar.bluetooth.service }}-running:
  service.running:
    - name: {{ pillar.bluetooth.service }}
    - require:
      - service: {{ pillar.bluetooth.service }}-enabled
