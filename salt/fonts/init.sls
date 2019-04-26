# Install custom fonts

{% for f in pillar['fonts']['ttf_files'] %}
{{ pillar.fonts.ttf_install_directory }}/{{ f }}:
  file.managed:
    - source: salt://fonts/ttf/{{ f }}
    - mode: 644
{% endfor %}
