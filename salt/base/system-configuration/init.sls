# General system configuration.

# rc.conf
{{ pillar.system_configuration.rc_file }}:
  file.managed:
    - source: salt://system-configuration/rc.conf
    - template: jinja
    - mode: 644

# Locales
{{ pillar.system_configuration.locale_file }}:
  file.managed:
    - source: salt://system-configuration/libc-locales
    - mode: 644

locales_reconfigure:
  cmd.run:
    - name: xbps-reconfigure -f glibc-locales
    - onchanges:
      - file: {{ pillar.system_configuration.locale_file }}
