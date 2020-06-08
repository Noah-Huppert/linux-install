# Installs support for exfat file systems.

{% for pkg in pillar['exfat']['pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}
