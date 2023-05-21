# Configures power management

{{ pillar.power_management.logind_conf }}:
  file.managed:
    - source: salt://power-management/logind.conf
    - template: jinja
