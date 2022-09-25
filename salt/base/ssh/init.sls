# Install and configure SSH

# Install
{% for pkg in pillar['ssh']['pkgs'] %}
  {{ pkg }}:
    pkg.latest
{% endfor %}

# Configure
{{ pillar.ssh.config_file }}:
  file.managed:
    - source: salt://ssh/noah.config
    - user: noah
    - group: noah
    - mode: 600
