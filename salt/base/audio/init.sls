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

# Enable user services
{% for _, user in pillar['users']['users'].items() %}
{% for svc in pillar['audio']['user_services'] %}
{{ user.home }}/{{ pillar.user_service_manager.services_config_dir }}/{{ svc }}:
  file.managed:
    - content: ""
    - user: {{ user.name }}
    - group: {{ user.name }}
{% endfor %}
{% endfor %}

# Volume control script
{{ pillar.audio.volume_control_script }}:
  file.managed:
    - source: salt://audio/volumectl
    - makdirs: True
    - mode: 755
