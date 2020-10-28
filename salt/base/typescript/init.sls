{% for pkg in pillar['typescript']['pkgs'] %}
{{ pkg }}:
  npm.installed
{% endfor %}
