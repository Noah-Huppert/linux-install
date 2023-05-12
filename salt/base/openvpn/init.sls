# Installs OpenVPN

{% for pkg in pillar['openvpn']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{{ pillar.openvpn.configs_dir }}:
  archive.extracted:
    - source: {{ pillar.openvpn.pia_zip.url }}
    - source_hash: {{ pillar.openvpn.pia_zip.sha256sum }}
    - enforce_toplevel: False

{% for profile in pillar['openvpn']['client_profiles'] %}
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
