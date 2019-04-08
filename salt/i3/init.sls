# Install and configure i3

# Install
{% for pkg in pillar['i3']['pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}

# Configure i3
{{ pillar.i3.configuration_file }}:
  file.managed:
    - source: salt://i3/config
    - makedirs: True
    - template: jinja
    - user: noah
    - group: noah
    - mode: 644
