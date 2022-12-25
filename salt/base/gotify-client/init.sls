# Installs gotify-cli from xbps.
# src=SRC
{% for pkg in pillar['gotify_client']['xbps_gotify_client_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
