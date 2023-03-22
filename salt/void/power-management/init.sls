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

# # Disable the laptop power management service acpid. Instead elogind from the sway service will handle thing.
{{ pillar.power_management.suspend_svc }}-disabled:
  service.disabled:
    - name: {{ pillar.power_management.suspend_svc }}

{{ pillar.power_management.suspend_svc }}-dead:
  service.dead:
    - name: {{ pillar.power_management.suspend_svc }}

