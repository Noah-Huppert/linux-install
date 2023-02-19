# Sets up a mechanism through which Salt states can describe the desired state of Systemd user services. This state will then be reconciled via a shell-profile unit at the login time of the user. This is because Systemd user services can only be control from within a user's session.
# A directory specified by {{ pillar.salt_systemd_user_service_control.user_config_dir }} is created. To specify a service's state create a file in this directory with the service's name. Then 

{% for _, user in pillar['users']['users'] %}
{{ user.home }}/{{ pillar.salt_systemd_user_service_control.user_config_dir }}:
  file.directory:
    - group: {{ user.name }}
    - user: {{ user.name }}
    - makedirs: True
{% endfor %}

{{ pillar.salt_systemd_user_service_script.script_path }}:
  file.managed:
    - source: salt://salt-systemd-user-service-script/salt-systemd-user-service.sh
    - mode: 755
    - makedirs: True