# Install and configure Dunst

# Install
{{ pillar.dunst.pkg }}:
  pkg.latest

# Configure
{{ pillar.dunst.configuration_file }}:
  file.managed:
    - source: salt://dunst/configuration/dunst.conf
    - makedirs: True
    - user: noah
    - group: noah
    - mode: 644
