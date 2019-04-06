# Install misc. utilities.

# XBPS
{% for pkg in pillar['utilities']['xbps_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

# Python 3
{% for pkg in pillar['utilities']['python3_pkgs'] %}
{{ pkg }}:
  pip.installed:
    - pip_bin: {{ pillar.python.pip3_bin }}
{% endfor %}