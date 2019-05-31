# Install Node JS

{% for pkg in pillar['nodejs']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
