# Configure audio

# Install
{% for pkg in pillar['audio']['pkgs'] %}
{{ pkg }}:
  pkg.latest
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

# Volume control script
{{ pillar.audio.volume_control_script }}:
  file.managed:
    - source: salt://audio/volumectl
    - makdirs: True
    - mode: 755
