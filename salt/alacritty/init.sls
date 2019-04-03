# Install Alacritty terminal

# Install
{{ pillar.alacritty.pkg }}:
  pkg.installed

# Configuration
{{ pillar.alacritty.configuration_file }}:
  file.managed:
    - source: salt://alacritty/alacritty.yaml
    - makedirs: True
    - user: noah
    - group: noah
    - mode: 644

