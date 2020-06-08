{% set named_dir = '/etc/named' %}

local_dns:
  # Disables local DNS server in favor of DNS IPs provided by DHCP
  # This value is set automatically in the script.sls file by the
  # local-dns script 
  # disabled: True

  # Toggle script configuration
  toggle_script:
    # Location of pillar file where the toggle script will set the disabled value.
    # Relative to the pillar root directory.
    pillar_file: local-dns/script.sls

    # Install location
    install_file: /usr/bin/local-dns
  
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
    
