internet:
  pkgs: []
  
  # WPA supplicant configuration
  wpa_supplicant:
    # Configuration file
    config_file: /etc/wpa_supplicant/wpa_supplicant.conf

    # Service
    service: wpa_supplicant

  # DHCPCD configuration
  dhcpcd:
    # Service
    service: dhcpcd


  # OpenVPN configuration
  openvpn:
    vpn_certs_dir: /opt/openvpn-certs/
