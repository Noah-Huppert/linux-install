# Installs GIMP
{% for pkg in pillar['gimp']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
