# Install NTP daemon and tools.

# Install
{{ pillar.ntp.pkg }}:
  pkg.latest

# Service
{{ pillar.ntp.service }}-enabled:
  service.enabled:
    - name: {{ pillar.ntp.service }}
    - require:
      - pkg: {{ pillar.ntp.pkg }}

{{ pillar.ntp.service }}-running:
  service.running:
    - name: {{ pillar.ntp.service }}
    - require:
      - service: {{ pillar.ntp.service }}-enabled
