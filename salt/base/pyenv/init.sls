# Installs pyenv, a Python version manager.

{% for _, user in pillar['users']['users'].items() %}
{{ user.home }}/{{ pillar.pyenv.install_dir }}:
  archive.extracted:
    - source: {{ pillar.pyenv.download_url }}
    - source_hash: {{ pillar.pyenv.download_sha256 }}
    - user: {{ user.name }}
    - group: {{ user.name }}
{% endfor %}
