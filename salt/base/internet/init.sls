# Configure dhcpcd and wpa_supplicant to connect to the internet

# Configure wpa_supplicant
{{ pillar.internet.wpa_supplicant.config_file }}:
  file.managed:
    - source: salt://internet/wpa_supplicant/wpa_supplicant.conf
    - template: jinja
    - mode: 640

{{ pillar.internet.wpa_supplicant.service }}-enabled:
  service.enabled:
    - name: {{ pillar.internet.wpa_supplicant.service }}
    - require:
      - file: {{ pillar.internet.wpa_supplicant.config_file }}

{{ pillar.internet.wpa_supplicant.service }}-running:
  service.running:
    - name: {{ pillar.internet.wpa_supplicant.service }}
    - watch:
      - file: {{ pillar.internet.wpa_supplicant.config_file }}
    - require:
        - service: {{ pillar.internet.wpa_supplicant.service }}-enabled

# Configure DHCPCD
{{ pillar.internet.dhcpcd.service }}-enabled:
  service.enabled:
    - name: {{ pillar.internet.dhcpcd.service }}

{{ pillar.internet.dhcpcd.service }}-running:
  service.running:
    - name: {{ pillar.internet.dhcpcd.service }}
    - require:
      - service: {{ pillar.internet.dhcpcd.service }}-enabled
