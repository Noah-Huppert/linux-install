# Install and configure i3

# Install
{% for pkg in pillar['i3']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

# Configure i3
{{ pillar.i3.configuration_file }}:
  file.managed:
    - source: salt://i3/configuration/i3
    - makedirs: True
    - user: noah
    - group: noah
    - mode: 644
