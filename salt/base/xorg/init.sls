# Install and configure Xorg display server and driver.

# Install
xorg_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.xorg.pkgs }}
      
# Configure
{% for user in pillar['users']['users'].values() %}
{{ user['home'] }}/{{ pillar.xorg.configuration_file }}:
  file.managed:
    - source: salt://xorg/xinit
    - user: {{ user['name'] }}
    - group: {{ user['name'] }}
    - mode: 744
      
{{ user['home'] }}/{{ pillar.xorg.xresources_file }}:
  file.managed:
    - source: salt://xorg/Xresources
    - user: {{ user['name'] }}
    - group: {{ user['name'] }}
{% endfor %}
