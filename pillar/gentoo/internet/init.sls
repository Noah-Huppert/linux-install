{% set wifi_iface = "wlp166s0" %}

internet:
  pkgs:
    - net-misc/dhcpcd
  
  wpa_supplicant:
    config_file: /etc/wpa_supplicant/wpa_supplicant-{{ wifi_iface }}.conf
    service: 'wpa_supplicant@{{ wifi_iface }}'
    
  dhcpcd:
    service: dhcpcd