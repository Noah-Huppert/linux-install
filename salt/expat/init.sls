# Installs expat
{% for pkg in pillar['expat']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
