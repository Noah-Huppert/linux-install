openvpn:
  pkgs: []

  # Directory where PIA configurations will be downloaded
  configs_dir: /etc/openvpn/client

  # PIA configurations download
  pia_zip:
    url: https://www.privateinternetaccess.com/openvpn/openvpn.zip
    sha256sum: bc38427782aedc90cb65b322cd6f9d74af4e988cc5b3c884e43236ed7a5e4491

  # PIA configuration profiles which will be setup to work with OpenVPN
  # - File extension renamed .ovpn -> .conf
  # - auth-user-pass file directive inserted
  pia_client_profiles:
    - us_east

  # Location of file which will contain PIA login credentials
  creds_file: /etc/openvpn/auth
