{% set dir = '/etc/wireguard' %}

wireguard:
  # Package
  pkg: wireguard

  # Directory
  directory: {{ dir }}

  # Configuration file
  configuration_file: {{ dir }}/wg0.conf

  # Interface
  interface: wg0

  # Peer information
  peers:
    # Server
    # Endpoint at which server can be reached
    - endpoint: funkyboy.zone:51820
      public_key: "7wQ1mXzgFDan86NOSNHgMisL9GfUJQabyhVWzj6w2jw="

      # VPN address of server
      ip: 192.168.10.1/24

  # Script to check if Wireguard interface is up
  check_interface_script: {{ dir }}/check-interface.sh
