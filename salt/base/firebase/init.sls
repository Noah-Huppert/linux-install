# Installs firebase-tools from npm.
# src=SRC
{% for pkg in pillar['firebase']['npm_firebase_pkgs'] %}
{{ pkg }}:
  npm.installed
{% endfor %}
