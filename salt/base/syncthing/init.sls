# Installs syncthing

{{ pillar.syncthing.pkg }}:
   pkg.installed

{% for user in pillar['users']['users'].values() %}
{{ user.home }}/{{ pillar.user_service_manager.services_config_dir }}/{{ pillar.syncthing.svc }}:
  file.managed:
    - require:
      - pkg: {{ pillar.syncthing.pkg }}
{% endfor %}


