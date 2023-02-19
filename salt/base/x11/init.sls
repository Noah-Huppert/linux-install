# Install X11
{% for pkg in pillar['x11']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}