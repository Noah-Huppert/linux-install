# Configure audio

# Install
{% for pkg in pillar['audio']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

# Enable services
{% for svc in pillar['audio']['services'] %}
{{ svc }}-enabled:
  service.enabled:
    - name: {{ svc }}
    - require:
    {%- for pkg in pillar['audio']['pkgs'] %}
      - pkg: {{ pkg }}
    {%- endfor %}

{{ svc }}-running:
  service.running:
    - name: {{ svc }}
    - require:
      - service: {{ svc }}-enabled
{% endfor %}