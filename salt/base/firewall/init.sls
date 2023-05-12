# Installs firewall tools
{% for pkg in pillar['firewall']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
