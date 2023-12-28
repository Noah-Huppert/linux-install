# Installs syncthing

syncthing_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.syncthing.pkgs }}

{% for user in pillar['users']['users'].values() %}
{% if user['name'] != "root" %}
{{ user['name'] }}_syncthing_svc:
  user_service.enabled:
    - name: {{ pillar.syncthing.svc }}
    - user: {{ user['name'] }}
    - require:
      - pkg: syncthing_pkgs
{% endif %}
{% endfor %}


