# Install NTP daemon and tools.

# Install
{{ pillar.ntp.pkg }}:
  pkg.installed

# Service
{{ pillar.ntp.service }}-enabled:
  service.enabled:
    - name: {{ pillar.ntp.service }}
    - require:
      - pkg: {{ pillar.ntp.pkg }}

{{ pillar.ntp.service }}-running:
  service.enabled:
    - name: {{ pillar.ntp.service }}
    - require:
      - service: {{ pillar.ntp.service }}-enabled
