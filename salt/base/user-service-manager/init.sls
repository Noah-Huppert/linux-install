# Allows easier enabling and disabling of user services by placing files in a special directory. This makes it possible for Salt states to specify that a user service should be run. Salt cannot normally easily do this bc "systemctl --user" commands need to run in logind sessions and if one wanted to make symlinks the symlink locations aren't obvious.

# Create config directory
{% for _, user in pillar['users']['users'].items() %}
{{ user.home }}/{{ pillar.user_service_manager.services_config_dir }}:
  file.directory:
    - group: {{ user.name }}
    - user: {{ user.name }}
    - makedirs: True
{% endfor %}

# Create service
{{ pillar.user_service_manager.script_path }}:
  file.managed:
    - source: salt://user-service-manager/manage-user-services.sh
    - template: jinja
    - mode: 755
    - makedirs: True

{{ pillar.user_service_manager.svc_file }}:
  file.managed:
    - source: salt://user-service-manager/user-service-manager.service
    - template: jinja
    - mode: 644

# Enable service for each user
{% for _, user in pillar['users']['users'].items() %}
{{ user.home }}/{{ pillar.user_service_manager.svc_enable_link }}:
  file.symlink:
    - target: {{ pillar.user_service_manager.svc_file }}
    - makedirs: True
    - require:
      - file: {{ pillar.user_service_manager.svc_file }}
{% endfor %}