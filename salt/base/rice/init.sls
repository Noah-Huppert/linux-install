# Setup visual look and feel of X resources.

# Install rice XBPS packages
{% for pkg in pillar['rice']['os_pkgs'] %}

{{ pkg }}:
  pkg.latest

{% endfor %}

# Install rice Python 3 packages
{% for pkg in pillar['rice']['python3_pkgs'] %}
{{ pkg }}:
  pip.installed:
    - bin_env: {{ pillar.python.pip3_bin }}
{% endfor %}

# Images
{% for img in pillar['rice']['images'] %}
{{ pillar.rice.images_directory }}/{{ img }}:
  file.managed:
    - source: salt://rice/pictures/{{ img }}
    - makedirs: True
    - mode: 644
{% endfor %}
