# Configures runit to run services for specific users.

# Configure runsvdir service to run as each user
{% for _, user in pillar['users']['users'].items() %}
{% set user_svc_dir = user.home + '/' + pillar.user_services.home_dir %}

{% set runit_svc_name = pillar.user_services.base_svc + '-' + user.name %}
{% set runit_svc_dir = '/etc/sv/' + runit_svc_name %}
{% set runit_svc_run_file = runit_svc_dir + '/run' %}
{% set runit_svc_var_dir = '/var/service/' + runit_svc_name %}

{{ user_svc_dir }}-exists:
  file.directory:
    - name: {{ user_svc_dir }}
    - user: {{ user.name }}
    - group: {{ user.name }}
    - mode: 755

{{ runit_svc_run_file }}:
  file.managed:
    - source: salt://user-services/run
    - template: jinja
    - makedirs: True
    - mode: 755
    - defaults:
        user_name: {{ user.name }}
        user_home: {{ user.home }}
        user_svc_dir: {{ user_svc_dir }}

# This was initially needed bc the symlink was not being created. However I
# cannot reproduce this behavior anymore, and service.enabled seems to be
# creating the symlink now.
#{{ runit_svc_var_dir }}:
#  file.symlink:
#    - target: {{ runit_svc_dir }}

{{ runit_svc_name }}-enabled:
  service.enabled:
    - name: {{ runit_svc_name }}
    - require:
      #- file: {{ runit_svc_var_dir }}
      - file: {{ runit_svc_run_file }}

{{ runit_svc_name }}-running:
  service.running:
    - name: {{ runit_svc_name }}
    - require:
      - service: {{ runit_svc_name }}-enabled
{% endfor %}

# Add a helper script to manage user services
{{ pillar.user_services.helper_install }}:
  file.managed:
    - source: salt://user-services/usv
    - template: jinja
    - mode: 755
