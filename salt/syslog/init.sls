# Sets up system log

# Install
{{ pillar.syslog.pkg }}:
  pkg.latest

# Enable services
{% for svc in pillar['syslog']['svcs'] %}
{{ svc }}-enabled:
  service.enabled:
    - name: {{ svc }}
    - require:
      - pkg: {{ pillar.syslog.pkg }}

{{ svc }}-running:
  service.running:
    - name: {{ svc }}
    - require:
      - service: {{ svc }}-enabled
{% endfor %}
