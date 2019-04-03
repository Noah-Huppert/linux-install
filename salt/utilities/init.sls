# Install misc. utilities.

{% for pkg in pillar['utilities']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
