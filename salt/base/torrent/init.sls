# Installs transmission from xbps.
# src=SRC
{% for pkg in pillar['torrent']['xbps_torrent_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{% for _, user in pillar['users']['users'].items() %}
transmission-config-{{ user.name }}:
  file.managed:
    - name: {{ user.home }}/{{ pillar.torrent.transmission_file }}
    - source: salt://torrent/transmission-settings.json
    - template: jinja
    - user: {{ user.name }}
    - group: {{ user.name }}
    - chmod: 650
    - context:
        template_user_home: {{ user.home }}
    - require:
      - pkg: {{ pillar.torrent.transmission_core_pkg }}
{% endfor %}

{{ pillar.torrent.transmission_svc }}-enabled:
  service.enabled:
    - name: {{ pillar.torrent.transmission_svc }}

{{ pillar.torrent.transmission_svc }}-running:
  service.running:
    - name: {{ pillar.torrent.transmission_svc }}
    - require:
      - service: {{ pillar.torrent.transmission_svc }}-enabled
