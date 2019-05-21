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

      # Tyler Charlinti's Wifi
      tyler_wifi:
        ssid: '"Wi so Fi?"'

      # Home
      home:
        ssid: '"Katla-5G"'

      # Chris's House
      chris:
        ssid: '"4GMY8"'

      # Cambrio Boston
      cambrio:
        ssid: '"WiFi Secure"'
        key_mgmt: WPA-EAP
        eap: TTLS
        phase2: '"auth=PAP"'

      # RedHat Westford
      redhat:
        ssid: '"Red Hat Guest"'
    

  # DHCPCD configuration
  dhcpcd:
    # Service
    service: dhcpcd
