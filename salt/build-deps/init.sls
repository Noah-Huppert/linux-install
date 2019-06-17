# Installs miscellaneous build dependencies
{% for pkg in pillar['build_deps']['pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}  
