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
        priority: 1

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

      # Jeff Sudbury
      jeff_sudbury:
        ssid: '"Fios-XMPR0"'

      # Panera
      panera:
        ssid: '"PANERA"'
        key_mgmt: NONE

      # Pixel 2 Hotspot
      noux:
        ssid: '"noux"'

      # Turris router
      turris:
        ssid: '"Turris"'
        priority: 2

      # Jeff's Dad's
      jeff_dad:
        ssid: '"jeffabbyjulia"'
        
      # Jeff's Dad's Lake House July 2019
      jeff_dad_nh_2019:
        ssid: '"MySpectrumWiFi8f-5G"'

      # Portland Oregon Maker apartment 2019 summer
      portland_or_maker_apartment:
        ssid: '"CenturyLink3710"'

      # Seattle Washington apartment 2019 summer
      seattle_wa_apartment:
        ssid: '"Nick''s Guest"'

      # North Hampton
      north_hamptons:
        ssid: '"LionsPride_5G"'

      # Hack Holyoke 2019
      hack_holyoke_2019:
        ssid: '"LyonNet-Encrypt"'

      # New York hotel
      nyc_hotel:
        ssid: '"CITY ROOMS NYC TSQ"'

      # Uncle NYC
      uncle_nyc:
        ssid: '"Zorra139-5G"'

      # Portland Airbnb
      portland_airbnb:
        ssid: '"SBG6900AC-6B573-5G"'

      # Montreal Airbnb
      montreal_airbnb:
        ssid: '"BELL400"'

      # Congreve apartment
      congreve:
        ssid: '"TP-Link_FAC0"'

  # DHCPCD configuration
  dhcpcd:
    # Service
    service: dhcpcd
