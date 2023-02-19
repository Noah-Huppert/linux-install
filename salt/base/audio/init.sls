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
user-{{ user.name }}-{{ svc }}:
  cmd.run:
    - name: {{ pillar.salt_systemd_user_service_script.script_path }} -e -n -u {{ svc }}
    - unless: {{ pillar.salt_systemd_user_service_script.script_path }} -c -e -n -u {{ svc }}
    - runas: {{ user.name }}
    - require:
    {%- for pkg in pillar['audio']['pkgs'] %}
      - pkg: {{ pkg }}
    {%- endfor %}
{% endfor %}
{% endfor %}

# Volume control script
{{ pillar.audio.volume_control_script }}:
  file.managed:
    - source: salt://audio/volumectl
    - makdirs: True
    - mode: 755
