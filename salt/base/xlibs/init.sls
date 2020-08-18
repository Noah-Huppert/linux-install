{% for pkg in pillar['xlibs']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
