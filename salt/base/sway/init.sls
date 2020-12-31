# Installs sway from xbps.
{% for pkg in pillar['sway']['xbps_sway_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{% for _, user in pillar['users']['users'].items() %}
# Sway
{{ user.home }}/{{ pillar.sway.sway_config_file }}-{{ user.name }}:
  file.managed:
    - name: {{ user.home }}/{{ pillar.sway.sway_config_file }}
    - source: salt://sway/sway-config.conf
    - template: jinja
    - mode: 644
    - makedirs: True
    - user: {{ user.name }}
    - group: {{ user.name }}

# Waybar
{{ user.home }}/{{ pillar.sway.waybar_config_file }}-{{ user.name }}:
  file.managed:
    - name: {{ user.home }}/{{ pillar.sway.waybar_config_file }}
    - source: salt://sway/waybar-config.json
    - mode: 644
    - makedirs: True
    - user: {{ user.name }}
    - group: {{ user.name }}

{{ user.home }}/{{ pillar.sway.waybar_style_file }}-{{ user.name }}:
  file.managed:
    - name: {{ user.home }}/{{ pillar.sway.waybar_style_file }}
    - source: salt://sway/waybar-style.css
    - mode: 644
    - makedirs: True
    - user: {{ user.name }}
    - group: {{ user.name }}

# Swaynag
{{ user.home }}/{{ pillar.sway.swaynag_config_file }}-{{ user.name }}:
  file.managed:
    - name: {{ user.home }}/{{ pillar.sway.swaynag_config_file }}
    - source: salt://sway/swaynag-config.ini
    - mode: 644
    - makedirs: True
    - user: {{ user.name }}
    - group: {{ user.name }}
{% endfor %}

{{ pillar.sway.swayexit_file }}:
  file.managed:
    - source: salt://sway/swayexit
    - mode: 755

{{ pillar.sway.wl_snip_file }}:
  file.managed:
    - source: salt://sway/wl-snip
    - mode: 755
