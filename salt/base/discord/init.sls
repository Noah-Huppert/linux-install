# Installs Discord
{% for pkg in pillar['discord']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
