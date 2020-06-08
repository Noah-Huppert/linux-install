# Install Firefox

{% for pkg in pillar['firefox']['pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}
