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

{% for profile in pillar['openvpn']['renamed_client_profiles'] %}
{{ pillar.openvpn.configs_dir }}/{{ profile }}.conf:
  file.symlink:
    - target: {{ pillar.openvpn.configs_dir }}/{{ profile }}.ovpn
    - requires:
      - archive: {{ pillar.openvpn.configs_dir }}
{% endfor %}
