# Configure suspend behavior

# Lock on suspend
{{ pillar.power_management.zzz_configuration_directory }}:
  file.recurse:
    - source: salt://power-management/zzz.d
    - clean: True
    - file_mode: 755
    - dir_mode: 755

# Enabled the laptop power management service
{{ pillar.power_management.tlp.pkg }}:
  pkg.latest

{{ pillar.power_management.tlp.svc }}-enabled:
  service.enabled:
    - name: {{ pillar.power_management.tlp.svc }}
    - require:
      - pkg: {{ pillar.power_management.tlp.pkg }}

{{ pillar.power_management.tlp.svc }}-running:
  service.running:
    - name: {{ pillar.power_management.tlp.svc }}
    - require:
      - service: {{ pillar.power_management.tlp.svc }}-enabled

# Enable acpid service to suspend on laptop close
{{ pillar.power_management.suspend_svc }}-enabled:
  service.enabled:
    - name: {{ pillar.power_management.suspend_svc }}

{{ pillar.power_management.suspend_svc }}-running:
  service.enabled:
    - name: {{ pillar.power_management.suspend_svc }}
    - require:
      - service: {{ pillar.power_management.suspend_svc }}-enabled

