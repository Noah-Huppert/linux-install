# Install Alacritty terminal

# Install
{{ pillar.alacritty.pkg }}:
  pkg.latest

# Configuration
{{ pillar.alacritty.configuration_file }}:
  file.managed:
    - source: salt://alacritty/alacritty.yml
    - makedirs: True
    - user: noah
    - group: noah
    - mode: 644

