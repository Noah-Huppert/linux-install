# Creates basic directories in each user's home

{% for _, user in pillar['users']['users'].items() %}

{% set home_dir = '/home/' + user.name %}
{% if user.name == 'root' %}
{% set home_dir = '/root' %}
{% endif %}

{% for dir in pillar['home_directories']['directories'] %}

{{ home_dir }}/{{ dir }}:
  file.directory:
    - makedirs: True
    - user: {{ user.name }}
    - group: {{ user.name }}
    - mode: 700

{% endfor %}
{% endfor %}
