# Setup network printing.
# Navigate to http://localhost:631 for the local web interface.
# Run system-config-printer for a GUI setup tool.

{{ pillar.printers.cfg_helper_pkg }}:
  pkg.installed

{{ pillar.printers.cups_pkg }}:
  pkg.installed

svc-enabled:
  service.enabled:
    - name: {{ pillar.printers.svc }}
    - require:
      - pkg: {{ pillar.printers.cups_pkg }}

svc-running:
  service.running:
    - name: {{ pillar.printers.svc }}
    - require:
      - service: svc-enabled
