# Install Python 2 and 3.

# Install
{% for pkg in pillar['python']['pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}
