# Installs p7zip from xbps.
# src=SRC
{% for pkg in pillar['p7zip']['xbps_p7zip_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
