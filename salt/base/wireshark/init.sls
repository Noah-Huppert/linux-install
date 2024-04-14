# Install Wireshark

wireshark_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.wireshark.pkgs }}

{{ pillar.wireshark.group }}-group:
  group.present:
    - name: {{ pillar.wireshark.group }}
    - addusers:
        - {{ pillar.users.users.noah.name }}
    - require:
      - pkg: wireshark_pkgs
