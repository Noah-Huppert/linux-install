# Installs dhcp from xbps.
# src=SRC
{% for pkg in pillar['dhcp_server']['xbps_dhcp_server_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
