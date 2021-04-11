# Installs asar from npm.
# src=SRC
{% for pkg in pillar['asar']['npm_asar_pkgs'] %}
{{ pkg }}:
  npm.installed
{% endfor %}
