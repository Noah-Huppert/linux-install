# Installs Chromium

{% for pkg in pillar['chrome']['pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}
