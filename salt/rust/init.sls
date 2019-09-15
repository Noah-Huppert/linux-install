# Installs the Rust language.

{% for pkg in pillar['rust']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}  
