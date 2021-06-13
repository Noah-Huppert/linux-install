# Installs ghc from xbps.
# src=SRC
{% for pkg in pillar['haskell']['xbps_haskell_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
