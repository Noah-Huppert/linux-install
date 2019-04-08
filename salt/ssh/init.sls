# Install and configure SSH

# Install
{{ pillar.ssh.pkg }}:
  pkg.latest

# Configure
{{ pillar.ssh.config_file }}:
  file.managed:
    - source: salt://ssh/noah.config
    - user: noah
    - group: noah
    - mode: 600
