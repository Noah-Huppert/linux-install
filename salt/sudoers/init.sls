# Configures the sudoers file to allow users in the wheel group to use sudo 
# without entering their password.

{{ pillar.sudoers.sudo_no_password_file }}:
  file.managed:
    - source: salt://sudoers/sudoers.d/sudo-no-password
    - template: jinja
