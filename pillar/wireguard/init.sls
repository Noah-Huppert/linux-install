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

  # Server information
  server:
    # Endpoint
    endpoint: funkyboy.zone:51820
    
    # Public key
    public_key: "7wQ1mXzgFDan86NOSNHgMisL9GfUJQabyhVWzj6w2jw="

  # Script to check if Wireguard interface is up
  check_interface_script: {{ dir }}/check-interface.sh
