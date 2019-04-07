# Install C development environment.

{% for pkg in pillar['c']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
