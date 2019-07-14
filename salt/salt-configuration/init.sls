# Configures the Salt minion to find Salt states in custom directories.
{{ pillar.salt_configuration.minion_config_file }}:
  file.managed:
    - source: salt://salt-configuration/minion
    - mode: 664
    - template: jinja

