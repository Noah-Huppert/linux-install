# Installs Open Broadcaster Software

{% for pkg in pillar['open_broadcaster_software']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
