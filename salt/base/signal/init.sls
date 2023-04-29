# Installs Signal desktop.
{% for pkg in pillar['signal']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
