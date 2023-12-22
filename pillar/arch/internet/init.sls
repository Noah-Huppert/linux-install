internet:
  pkgs:
    - networkmanager
    - networkmanager-openvpn

  svc: NetworkManager.service

  wifi_interface: wlp166s0
  connection_profiles_dir: /etc/NetworkManager/system-connections
