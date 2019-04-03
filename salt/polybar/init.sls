# Install and configure polybar.

# Install
{{ pillar.polybar.pkg }}:
  pkg.installed

# Configure
{{ pillar.polybar.launch_script_file }}:
  file.managed:
    - source: salt://polybar/launch.sh
    - makedirs: True
    - user: noah
    - group: noah
    - mode: 755

{{ pillar.polybar.config_file }}:
  file.managed:
    - source: salt://polybar/config
    - makedirs: True
    - user: noah
    - group: noah
    - mode: 644