# Configure dhcpcd and wpa_supplicant to connect to the internet

# Configure wpa_supplicant
{{ pillar.internet.wpa_supplicant.config_file }}:
  file.managed:
    - source: salt://internet/wpa_supplicant/wpa_supplicant.conf
    - template: jinja
    - mode: 640

{{ pillar.internet.wpa_supplicant.service }}:
  service.running:
    - enable: True
    - watch:
      - file: {{ pillar.internet.wpa_supplicant.config_file }}

# Configure DHCPCD
{{ pillar.internet.dhcpcd.service }}:
  service.running:
    - enable: True
