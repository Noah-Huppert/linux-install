{% set dir = '/etc/wireguard' %}

wireguard:
  # Package
  pkg: wireguard

  # Directory
  config: null
  #  directory: {{ dir }}

  # Configuration file
  #  configuration_file: {{ dir }}/wg0.conf

  # Interface
  #  interface: wg0

  # Script to check if Wireguard interface is up
  #  check_interface_script: {{ dir }}/check-interface.sh
