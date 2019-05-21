{% set named_dir = '/etc/named' %}

local_dns:
  # Toggles the use of the local DNS server
  enabled: False
  
  # BIND 9 configuration
  bind:
    # Package
    pkg: bind

    # Linux group
    group: named

    # Service
    svc: named

    # Listen address
    address: 127.0.0.1

    # Configuration file
    configuration_file: {{ named_dir }}/named.conf

    # Local control tool key
    rndc_key_file: {{ named_dir }}/rndc.key

    # Configuration file check command
    configuration_check_cmd: named-checkconf

    # Upstream DNS servers
    upstream_dns_servers:
      - 1.1.1.1
      - 1.0.0.1

  # Resolvconf configuration
  resolvconf:
    # Configuration file
    configuration_file: /etc/resolvconf.conf

    # Update command
    update_cmd: resolvconf -u

  # DHCPCD configuration
  dhcpcd:
    # Configuration file
    configuration_file: /etc/dhcpcd.conf

    # Service
    svc: dhcpcd
    
