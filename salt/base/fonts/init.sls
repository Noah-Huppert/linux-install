# Install custom fonts

# Install fonts from packages
{% for pkg in pillar['fonts']['font_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

# Install font files
{% for f in pillar['fonts']['ttf_files'] %}
{{ pillar.fonts.ttf_install_directory }}/{{ f }}:
  file.managed:
    - source: salt://fonts/ttf/{{ f }}
    - mode: 644
{% endfor %}

# Configuration file
{{ pillar.fonts.fonts_conf_file }}:
  file.managed:
    - source: salt://fonts/local.conf
    - mode: 644
