# General system configuration.

{{ pillar.system_configuration.rc_file }}:
  file.managed:
    - source: salt://system-configuration/rc.conf
    - template: jinja
