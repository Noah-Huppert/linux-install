# Install and configure OpenVPN to connect to Red Hat corporate network

# Install
{{ pillar.red_hat_vpn.open_vpn.pkg }}:
  pkg.latest

{{ pillar.red_hat_vpn.open_vpn.group }}-group:
  group.present:
    - name: {{ pillar.red_hat_vpn.open_vpn.group }}

# Red Hat VPN files
{{ pillar.red_hat_vpn.ca_cert }}:
  file.managed:
    - source: salt://red-hat-vpn-secret/RH-IT-Root-CA.crt
    - mode: 644
    - makedirs: True

{{ pillar.red_hat_vpn.open_vpn_config }}:
  file.managed:
    - source: salt://red-hat-vpn/RH-RDU2.ovpn
    - template: jinja
    - makedirs: True

{{ pillar.red_hat_vpn.open_vpn.up_plugin }}:
  file.managed:
    - source: salt://red-hat-vpn/client.up
    - mode: 755
    - makedirs: True

{{ pillar.red_hat_vpn.open_vpn.down_plugin.script }}:
  file.managed:
    - source: salt://red-hat-vpn/client.down
    - mode: 755
    - makedirs: True
