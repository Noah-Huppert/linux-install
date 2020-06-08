# Install freetype
{% for pkg in pillar['freetype']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
