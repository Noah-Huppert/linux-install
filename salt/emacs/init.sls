# Install and configure Emacs.

# Install
{{ pillar.emacs.pkg }}:
  pkg.installed

# Download plugins
{% for plugin in pillar['emacs']['plugin_files'] %}
{{ pillar.emacs.plugins_load_path }}/{{ plugin.name }}:
  file.managed:
    - source: {{ plugin.source }}
    - makedirs: True
    - skip_verify: True
    - user: noah
    - gorup: noah
    - mode: 644
{% endfor %}

# Configuration file
{{ pillar.emacs.configuration_file }}:
  file.managed:
    - source: salt://emacs/init.el
    - template: jinja
    - user: noah
    - group: noah
    - mode: 644
