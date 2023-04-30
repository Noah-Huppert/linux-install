# Install Go

{% for pkg in pillar['go']['pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}

