# Installs go from xbps.
# src=xbps
{% for pkg in pillar['go-wails']['golang_go-wails_pkgs'] %}
go install {{ pkg['url'] }}:
  cmd.run:
    - unless: which pkg['bin']
{% endfor %}
