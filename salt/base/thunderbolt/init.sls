# Configures thunderbolt support

{{ pillar.thunderbolt.pkg }}:
  pkg.installed

{{ pillar.thunderbolt.svc }}:
  service.running:
    - enable: True
    - require:
      - pkg: {{ pillar.thunderbolt.pkg }}
    
  