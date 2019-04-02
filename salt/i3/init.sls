# Install and configure i3

# Install
{{ pillar.i3.pkg }}:
  pkg.installed

# Configuration
{{ pillar.i3.configuration_file }}:
  file.managed:
    - source: salt://i3/configuration/i3
    - makedirs: True
    - user: noah
    - group: noah
    - mode: 644
