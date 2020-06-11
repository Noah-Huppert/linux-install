# Adds required APT package repositories.

{% for name, ppa in pillar['apt_repositories'].items() %}
{{ name }}-apt-repo:
  pkgrepo.managed:
    - ppa: {{ ppa }}
{% endfor %}