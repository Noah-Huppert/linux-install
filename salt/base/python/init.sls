# Install Python 2 and 3.

# Install
{% for pkg in pillar['python']['xbps_pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}

{% for pkg in pillar['python']['pip_pkgs'] %}
{{ pkg }}:
  pip.installed:
    - pip_bin: {{ pillar.python.pip3_bin }}
    - require:
      {% for xbps_pkg in pillar['python']['xbps_pkgs'] %}
      - pkg: {{ xbps_pkg }}
      {% endfor %}
{% endfor %}
