# Configure system to use a local BIND DNS server

# Install
{{ pillar.local_dns.bind.pkg }}:
  pkg.installed

# Named configuration
{{ pillar.local_dns.bind.configuration_file }}:
  file.managed:
    - source: salt://local-dns/named.conf
    - template: jinja
    - check_cmd: {{ pillar.local_dns.bind.configuration_check_cmd }}
    - mode: 640
    - user: root
    - group: {{ pillar.local_dns.bind.group }}
    - require:
      - pkg: {{ pillar.local_dns.bind.pkg }}

# Resolvconf configuration
{{ pillar.local_dns.resolvconf.configuration_file }}:
  file.managed:
    - source: salt://local-dns/resolvconf.conf
    - template: jinja
    - mode: 644

{{ pillar.local_dns.resolvconf.update_cmd }}:
  cmd.run:
    - onchanges:
        - file: {{ pillar.local_dns.resolvconf.configuration_file }}

# DHCPCD configuration
{{ pillar.local_dns.dhcpcd.configuration_file }}:
  file.managed:
    - source: salt://local-dns/dhcpcd.conf
    - template: jinja
    - mode: 644

{{ pillar.local_dns.dhcpcd.svc }}:
  service.running:
    - watch:
      - file: {{ pillar.local_dns.dhcpcd.configuration_file }}

# Start service
{{ pillar.local_dns.bind.svc }}-enabled:
  service.enabled:
    - name: {{ pillar.local_dns.bind.svc }}
    - require:
      - file: {{ pillar.local_dns.bind.configuration_file }}
      - file: {{ pillar.local_dns.resolvconf.configuration_file }}

{{ pillar.local_dns.bind.svc }}-running:
  service.running:
    - name: {{ pillar.local_dns.bind.svc }}
    - watch:
      - file: {{ pillar.local_dns.bind.configuration_file }}
    - require:
      - service: {{ pillar.local_dns.bind.svc }}-enabled
