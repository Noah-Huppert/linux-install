red_hat_vpn:
  open_vpn:
    # Open VPN package
    pkg: openvpn

    # User group
    group: openvpn

    # Up plugin file
    up_plugin: /etc/openvpn/client.up

    # Down plugin files
    down_plugin:
      lib: /usr/lib64/openvpn/plugins/openvpn-plugin-down-root.so
      script: /etc/openvpn/client.down

  # Red Hat IT TLS root certificate
  ca_cert: /etc/openvpn/RH-IT-Root-CA.pem
  #/etc/pki/tls/certs/2015-RH-IT-Root-CA.pem

  # Open VPN configuration file
  open_vpn_config: /etc/openvpn/client/RH-RDU2.ovpn
