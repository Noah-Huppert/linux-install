internet:
  # WPA supplicant configuration
  wpa_supplicant:
    # Configuration file
    config_file: /etc/wpa_supplicant/wpa_supplicant.conf

    # Service
    service: wpa_supplicant

    # Networks configuration, dict of objects which hold wpa_supplicant 
    # network options
    networks:
     # Eduroam school network. The identity and password fields are in the 
     # internet-secret pillar
      eduroam:
        ssid: '"eduroam"'
        key_mgmt: WPA-EAP
        eap: TTLS
        phase2: '"auth=PAP"'

  # DHCPCD configuration
  dhcpcd:
    # Service
    service: dhcpcd