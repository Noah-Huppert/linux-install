# Install device firmware
{% for pkg in pillar['firmware']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
