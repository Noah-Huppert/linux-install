# Configure suspend behavior

# Lock on suspend
{{ pillar.zzz.configuration_directory }}:
  file.recurse:
    - source: salt://zzz/zzz.d
    - clean: True
    - file_mode: 755
    - dir_mode: 755

# Enable acpid service to suspend on laptop close
{{ pillar.zzz.suspend_svc }}-enabled:
  service.enabled:
    - name: {{ pillar.zzz.suspend_svc }}

{{ pillar.zzz.suspend_svc }}-running:
  service.enabled:
    - name: {{ pillar.zzz.suspend_svc }}
    - require:
      - service: {{ pillar.zzz.suspend_svc }}-enabled
