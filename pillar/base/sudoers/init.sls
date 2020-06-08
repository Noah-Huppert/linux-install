{% import_yaml 'users/init.sls' as pillar_users %}
{% set users = pillar_users['users'] %}

sudoers:
  # File to configure sudoers
  sudo_no_password_file: /etc/sudoers.d/sudo-no-password

  # Group which is given sudo permissions
  sudo_group: {{ users['groups']['wheel']['name'] }}
