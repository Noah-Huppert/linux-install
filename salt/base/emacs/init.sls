# Install and configure Emacs.

# Configuration directory
{% for user_name in pillar['emacs']['users'] %}
{% set user = pillar['users']['users'][user_name] %}

{{ user.name }}-{{ pillar.emacs.configuration_repo }}:
  git.cloned:
    - name: {{ pillar.emacs.configuration_repo }}
    - target: {{ user.home }}/{{ pillar.emacs.configuration_directory }}
    - user: {{ user.name }}
{% endfor %}

# Install
emacs_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.emacs.pkgs }}

# Service
{% if pillar['emacs']['svc'] is not none %}
{% for _, user in pillar['users']['users'].items() %}
{{ user.home }}/{{ pillar.emacs.svc.file }}:
  file.managed:
    - source: salt://emacs/user-svc
    - makedirs: True
    - template: jinja
    - context:
        user_name: {{ user.name }}
    - user: {{ user.name }}
    - group: {{ user.name }}
    - mode: 755

{{ user.home }}/{{ pillar.user_service_manager.services_config_dir }}/{{ pillar.emacs.svc.name }}:
  file.managed:
    - contents: ""
{% endfor %}
{% endif %}
