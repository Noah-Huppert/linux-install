# Configures the sudoers file to allow users in the wheel group to use sudo 
# without entering their password.

{% if 'pkg' in pillar['sudoers'] and pillar['sudoers']['pkg'] is not none %}
{{ pillar.sudoers.pkg }}:
  pkg.installed
{% endif %}

{{ pillar.sudoers.sudo_no_password_file }}:
  file.managed:
    - source: salt://sudoers/sudoers.d/sudo-no-password
    - makedirs: True
    - template: jinja
    - check_cmd: visudo -c -f
    {% if 'pkg' in pillar['sudoers'] and pillar['sudoers']['pkg'] is not none -%}
    - require:
      - pkg: {{ pillar.sudoers.pkg }}
    {% endif -%}
