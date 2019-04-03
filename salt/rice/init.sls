# Setup visual look and feel of X resources.

# Install rice packages
{% for pkg in pillar['rice']['pkgs'] %}

{{ pkg }}:
  pkg.installed

{% endfor %}

# Images
{% for img in pillar['rice']['images'] %}
{{ pillar.rice.images_directory }}/{{ img }}:
  file.managed:
    - source: salt://rice/pictures/{{ img }}
    - makedirs: True
    - user: noah
    - group: noah
    - mode: 644
{% endfor %}