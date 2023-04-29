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
    - makedirs: true
{% endfor %}

# Global configuration file
{% if pillar['fonts']['fonts_conf_file'] is not none %}
{{ pillar.fonts.fonts_conf_file }}:
  file.managed:
    - source: salt://fonts/local.conf
    - mode: 644
{% endif %}


# Font units files
{{ pillar.fonts.fonts_avail_dir }}:
  file.recurse:
    - source: salt://fonts/conf.avail/
    - makedirs: true

{% for font_unit in pillar['fonts']['linked_avail_units'] %}
{{ pillar.fonts.fonts_enabled_dir }}/{{ font_unit }}:
  file.symlink:
    - target: {{ pillar.fonts.fonts_avail_dir }}/{{ font_unit }}
    - requires:
      - file: {{ pillar.fonts.fonts_avail_dir }}
{% endfor %}

{% for font_unit in pillar['fonts']['unlinked_avail_units'] %}
{{ pillar.fonts.fonts_enabled_dir }}/{{ font_unit }}:
  file.absent
{% endfor %}
