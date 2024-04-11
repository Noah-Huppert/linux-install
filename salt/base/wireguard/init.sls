# Install and configure Wireguard to connect to funkyboy.zone

# Install
{{ pillar.wireguard.pkg }}:
  pkg.installed

# Configure
{% if pillar['wireguard']['config'] is not none %}
{{ pillar.wireguard.config.directory }}:
  file.directory:
    - dir_mode: 755
  
{{ pillar.wireguard.config.configuration_file }}:
  file.managed:
    - source: salt://wireguard/wg0.conf
    - template: jinja
    - mode: 640
    - require:
      - file: {{ pillar.wireguard.config.directory }}

delete:
  cmd.run:
    - name: wg-quick down {{ pillar.wireguard.config.interface}} || true
    - require:
      - file: {{ pillar.wireguard.config.configuration_file }}
    - onchanges:
      - file: {{ pillar.wireguard.config.configuration_file }}

configure:
  cmd.run:
    - name: wg-quick up {{ pillar.wireguard.config.interface }}
    - require:
      - cmd: delete
    - onchanges:
      - file: {{ pillar.wireguard.config.configuration_file }}

# Check interface script
{{ pillar.wireguard.config.check_interface_script }}:
  file.managed:
    - source: salt://wireguard/check-interface.sh
    - mode: 755
    - require:
      - file: {{ pillar.wireguard.config.directory }}
{% endif %}
