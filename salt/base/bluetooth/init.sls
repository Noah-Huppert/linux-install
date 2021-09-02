# Install bluetooth service

# Install
{{ pillar.bluetooth.pkg }}:
  pkg.latest

{{ pillar.bluetooth.blueman_pkg }}:
  pkg.latest

# Configure
{{ pillar.bluetooth.main_config }}:
  file.managed:
    - source: salt://bluetooth/main.conf
    - mode: 644

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
