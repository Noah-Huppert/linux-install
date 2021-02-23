# Installs wasmtime from xbps.
# src=SRC
{% for pkg in pillar['wasmtime']['xbps_wasmtime_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
