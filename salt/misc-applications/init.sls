# Install misc. applications.

{% for pkg in pillar['misc_applications']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}