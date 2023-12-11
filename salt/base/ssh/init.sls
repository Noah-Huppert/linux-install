# Install and configure SSH

# Install
ssh_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.ssh.pkgs }}

# Configure
{{ pillar.ssh.config_file }}:
  file.managed:
    - source: salt://ssh/noah.config
    - user: noah
    - group: noah
    - mode: 600
