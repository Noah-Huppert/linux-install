# Installs Signal-Desktop from xbps.
# src=SRC
{% for pkg in pillar['signal']['xbps_signal_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
