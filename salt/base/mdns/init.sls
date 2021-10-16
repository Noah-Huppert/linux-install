# Installs avahi from xbps.
# src=SRC
{% for pkg in pillar['mdns']['xbps_mdns_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
