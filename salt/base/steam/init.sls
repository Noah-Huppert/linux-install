# Install Steam

{% for pkg in pillar['steam']['pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}
