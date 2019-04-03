# Setup visual look and feel of X resources.

# Install rice packages
{% for pkg in pillar['rice']['pkgs'] %}

{{ pkg }}:
  pkg.installed

{% endfor %}

# Background image
{{ pillar.rice.background_image_file }}:
  file.managed:
    - source: salt://rice/pictures/dog-flowers.jpg
    - makedirs: True
    - user: noah
    - group: noah
    - mode: 644
