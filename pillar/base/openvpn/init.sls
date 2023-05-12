openvpn:
  pkgs: []

  configs_dir: /etc/openvpn/client
  
  pia_zip:
    url: https://www.privateinternetaccess.com/openvpn/openvpn.zip
    sha256sum: bc38427782aedc90cb65b322cd6f9d74af4e988cc5b3c884e43236ed7a5e4491

  renamed_client_profiles:
    - us_east
