# Install and configure TMux

# Install
{{ pillar.tmux.pkg }}:
  pkg.installed

# Configure
{{ pillar.tmux.configuration_file }}:
  file.managed:
    - source: salt://tmux/configuration/tmux.conf
    - user: noah
    - group: noah
    - mode: 644