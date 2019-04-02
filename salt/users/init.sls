# Configure users

{% for _, user in pillar['users'].items() %}
{{ user.name }}:
  user.present:
    - password: {{ user.password_hash }}
{% endfor %}
