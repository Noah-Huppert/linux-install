# Installs transmission from xbps.
# src=SRC
{% for pkg in pillar['transmission_torrent']['xbps_torrent_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{% for _, user in pillar['users']['users'].items() %}
transmission-config-{{ user.name }}:
  file.managed:
    - name: {{ user.home }}/{{ pillar.transmission_torrent.transmission_file }}
    - source: salt://transmission-torrent/transmission-settings.json
    - template: jinja
    - user: {{ user.name }}
    - group: {{ user.name }}
    - chmod: 650
    - context:
        template_user_home: {{ user.home }}
    - require:
      - pkg: {{ pillar.transmission_torrent.transmission_core_pkg }}

{{ user.home }}/{{ pillar['transmission_torrent']['home_movies_dir'] }}:
  file.directory:
    - user: {{ user.name }}
    - group: {{ pillar['users']['groups']['movies']['name'] }}
    - dir_mode: 760
{% endfor %}

{{ pillar['users']['groups']['movies']['name'] }}:
  group.present:
    - addusers:
      - {{ pillar.transmission_torrent.transmission_user }}

{{ pillar.transmission_torrent.svc_file }}:
  file.managed:
    - source: salt://transmission-torrent/transmission-run
    - template: jinja
    - chmod: 760

# {{ pillar.transmission_torrent.transmission_svc }}-disabled:
#   service.disabled:
#     - name: {{ pillar.transmission_torrent.transmission_svc }}

# {{ pillar.transmission_torrent.transmission_svc }}-dead:
#   service.dead:
#     - name: {{ pillar.transmission_torrent.transmission_svc }}
