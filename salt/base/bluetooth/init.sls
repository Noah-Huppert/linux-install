# Install bluetooth service

# Install
{% for pkg in pillar['bluetooth']['pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}

# Service
{{ pillar.bluetooth.service }}-enabled:
  service.enabled:
    - name: {{ pillar.bluetooth.service }}
    - require:
      {% for pkg in pillar['bluetooth']['pkgs'] %}
      - pkg: {{ pkg }}
      {% endfor %}

{{ pillar.bluetooth.service }}-running:
  service.running:
    - name: {{ pillar.bluetooth.service }}
    - require:
      - service: {{ pillar.bluetooth.service }}-enabled
