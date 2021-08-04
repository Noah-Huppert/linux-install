# Installs typeorm from npm.
# src=SRC
{% for pkg in pillar['typeorm']['npm_typeorm_pkgs'] %}
{{ pkg }}:
  npm.installed
{% endfor %}
