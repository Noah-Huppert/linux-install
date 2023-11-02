# Installs OpenVPN

openvpn_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.openvpn.pkgs }}

openvpn_pia_extracted:
  archive.extracted:
    - name: {{ pillar.openvpn.configs_dir }}
    - source: {{ pillar.openvpn.pia_zip.url }}
    - source_hash: {{ pillar.openvpn.pia_zip.sha256sum }}
    - enforce_toplevel: False

openvpn_manual_client_configs:
  file.recurse:
    - name: {{ pillar.openvpn.configs_dir }}
    - source: salt://openvpn/client-configs
    - requires:
      - file: openvpn_pia_extracted

{% for profile in pillar['openvpn']['pia_client_profiles'] %}
{{ pillar.openvpn.configs_dir }}/{{ profile }}.conf:
  file.managed:
    - source: salt://openvpn/client-profile.conf
    - template: jinja
    - defaults:
        profile: {{ profile }}
    - requires:
      - archive: {{ pillar.openvpn.configs_dir }}
{% endfor %}

{{ pillar.openvpn.creds_file }}:
  file.managed:
    - source: salt://openvpn/pia-creds
    - makedirs: True
