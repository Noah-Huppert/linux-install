# Install and configure Emacs.

# Configuration directory
{{ pillar.emacs.configuration_repo }}:
  git.cloned:
    - target: {{ pillar.emacs.configuration_directory }}
    - user: noah

# Install
{% for pkg in pillar['emacs']['pkgs'] %}
{{ pkg }}:
  pkg.latest:
    - required:
      - git: {{ pillar.emacs.configuration_repo }}

{% endfor %}

# Service
{% for _, user in pillar['users']['users'].items() %}

# Name of user specific emacs service
{% set user_svc = pillar['emacs']['base_svc_name'] + '-' + user.name %}

# User's emacs service file
{% set user_svc_dir = user.home + '/' + pillar['user_services']['home_dir'] + '/' + pillar['emacs']['base_svc_name'] %}
{% set user_svc_file = user_svc_dir + '/run' %}
{% set user_svc_log_file = user_svc_dir + '/log/run' %}

# Global system service directory
{% set svc_link_dest = '/etc/sv/' + user_svc %}

{{ user_svc_file }}:
  file.managed:
    - makedirs: True
    - template: jinja
    - contents: |
        #!/usr/bin/env bash
        exec emacs --fg-daemon &> /tmp/emacs-noah.log
    - user: {{ user.name }}
    - group: {{ user.name }}
    - mode: 755

{{ user_svc_log_file }}:
  file.managed:
    - makedirs: True
    - template: jinja
    - contents: |
        #!/usr/bin/env bash
        exec logger -t {{ user_svc }}
    - user: {{ user.name }}
    - group: {{ user.name }}
    - mode: 755
{% endfor %}
