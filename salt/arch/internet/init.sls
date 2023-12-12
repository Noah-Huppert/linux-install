# Install and configure NetworkManager

# Install packages
internet_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.internet.pkgs }}

{{ pillar.internet.svc }}:
  service.running:
    - enable: True
    - require:
      - pkg: internet_pkgs

# Configure connection profiles
{% for name, config in pillar['internet']['wpa_supplicant']['networks'].items() %}
{{ pillar.internet.connection_profiles_dir }}/{{ name }}.nmconnection:
  file.managed:
    - source: salt://internet/connection.nmconnection
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - defaults:
        name: {{ name }}
        config: {{ config }}
    - require:
      - pkg: internet_pkgs
{% endfor %}
