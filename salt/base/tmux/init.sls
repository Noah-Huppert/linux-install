# Install and configure TMux

# Install
{{ pillar.tmux.pkg }}:
  pkg.latest

# Configure
{{ pillar.tmux.configuration_file }}:
  file.managed:
    - source: salt://tmux/tmux.conf
    - user: noah
    - group: noah
    - mode: 644
