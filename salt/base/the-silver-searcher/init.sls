# Installs the_silver_searcher from xbps.
# src=SRC
{% for pkg in pillar['the_silver_searcher']['xbps_the_silver_searcher_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
