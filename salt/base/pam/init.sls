# Sets up PAM
{{ pillar.pam.login_conf }}:
  file.managed:
    - source: salt://pam/login
