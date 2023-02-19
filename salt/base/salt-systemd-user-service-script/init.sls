# Installs a script which other states can use to enable and run systemd user services.
{{ pillar.salt_systemd_user_service_script.script_path }}:
  file.managed:
    - source: salt://salt-systemd-user-service-script/salt-systemd-user-service.sh
    - mode: 755
    - makedirs: True