# Install Wireshark

{% for pkg in pillar['wireshark']['pkgs'] %}
{{ pkg }}-installed:
  pkg.installed:
    - name: {{ pkg }}

{% endfor %}

{{ pillar.wireshark.group }}-group:
  group.present:
    - name: {{ pillar.wireshark.group }}
    - addusers:
        - {{ pillar.users.users.noah.name }}
    - require:
      {% for pkg in pillar['wireshark']['pkgs'] %}
      - pkg: {{ pkg }}-installed
      {% endfor %}
        
