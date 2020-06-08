# Install and configure Wireguard to connect to funkyboy.zone

# Install
{{ pillar.wireguard.pkg }}:
  pkg.latest

# Configure
{{ pillar.wireguard.directory }}:
  file.directory:
    - dir_mode: 755
  
{{ pillar.wireguard.configuration_file }}:
  file.managed:
    - source: salt://wireguard/wg0.conf
    - template: jinja
    - mode: 640
    - require:
      - file: {{ pillar.wireguard.directory }}

delete:
  cmd.run:
    - name: wg-quick down {{ pillar.wireguard.interface}} || true
    - require:
      - file: {{ pillar.wireguard.configuration_file }}
    - onchanges:
      - file: {{ pillar.wireguard.configuration_file }}

configure:
  cmd.run:
    - name: wg-quick up {{ pillar.wireguard.interface }}
    - require:
      - cmd: delete
    - onchanges:
      - file: {{ pillar.wireguard.configuration_file }}

# Check interface script
{{ pillar.wireguard.check_interface_script }}:
  file.managed:
    - source: salt://wireguard/check-interface.sh
    - mode: 755
    - require:
      - file: {{ pillar.wireguard.directory }}
