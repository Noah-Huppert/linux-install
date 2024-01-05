# Installs syncthing

syncthing_pkgs:
  multipkg.installed:
    - pkgs: {{ pillar.syncthing.pkgs }}

{% for user in pillar['users']['users'].values() %}
{% if user['name'] != "root" %}
{{ user['name'] }}_syncthing_svc:
  user_service.enabled:
    - name: {{ pillar.syncthing.svc }}
    - user: {{ user['name'] }}
    - start: True
    - require:
      - multipkg: syncthing_pkgs
{% endif %}
{% endfor %}


