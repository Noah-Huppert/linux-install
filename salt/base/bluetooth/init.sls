# Install bluetooth service

# Install
bluetooth_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.bluetooth.pkgs }}

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
      - pkg: bluetooth_pkgs

{{ pillar.bluetooth.service }}-running:
  service.running:
    - name: {{ pillar.bluetooth.service }}
    - require:
      - service: {{ pillar.bluetooth.service }}-enabled
