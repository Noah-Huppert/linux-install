# Installs ARM MBed CLI

{% for pkg in pillar['mbed']['pip_pkgs'] %}
{{ pkg }}:
  pip.installed:
    - pip_bin: {{ pillar.python.pip2_bin }}
{% endfor %}
