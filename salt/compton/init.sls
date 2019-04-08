# Install and configure Compton

# Install
{{ pillar.compton.pkg }}:
  pkg.latest

# Configure
{{ pillar.compton.configuration_file }}:
  file.managed:
    - source: salt://compton/configuration/compton.conf
    - makedirs: True
    - user: noah
    - group: noah
    - mode: 644
