# Installs tor
{% for pkg in pillar['tor']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
