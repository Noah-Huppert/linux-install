# Installs sway from xbps.
{% for pkg in pillar['sway']['xbps_sway_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{% for _, user in pillar['users']['users'].items() %}
{{ user.home }}/{{ pillar.sway.sway_config_file }}-{{ user.name }}:
  file.managed:
    - name: {{ user.home }}/{{ pillar.sway.sway_config_file }}
    - source: salt://sway/config
    - mode: 644
    - makedirs: True

{{ user.home }}/{{ pillar.sway.waybar_config_file }}-{{ user.name }}:
  file.managed:
    - name: {{ user.home }}/{{ pillar.sway.waybar_config_file }}
    - source: salt://sway/waybar
    - mode: 644
    - makedirs: True

{{ user.home }}/{{ pillar.sway.waybar_style_file }}-{{ user.name }}:
  file.managed:
    - name: {{ user.home }}/{{ pillar.sway.waybar_style_file }}
    - source: salt://sway/waybar-style.css
    - mode: 644
    - makedirs: True
{% endfor %}

{{ pillar.sway.swayexit_file }}:
  file.managed:
    - source: salt://sway/swayexit
    - mode: 755
