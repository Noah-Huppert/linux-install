# Install Alacritty terminal

# Install
{{ pillar.alacritty.pkg }}:
  pkg.installed

# Configuration
{{ pillar.alacritty.configuration_file }}:
  file.managed:
    - source: salt://alacritty/configuration/alacritty.yml
    - makedirs: True
    - user: noah
    - group: noah
    - mode: 644

