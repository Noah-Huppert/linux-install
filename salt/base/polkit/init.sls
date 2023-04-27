# Installs Polkit

{% for pkg in pillar['polkit']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}