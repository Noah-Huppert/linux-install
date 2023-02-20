{% set user_config_dir = ".config/user-service-manager" %}

user_service_manager:
  # Directory where names of user services to enable will be placed.
  # To enable a user service make a file with that service's name, content is not read.
  # Relative to user's home directory.
  services_config_dir: {{ user_config_dir }}/services.d/

  # File containing list of services which the tool enabled in its last run.
  # Created and controlled by the script.
  # Relative to the user's home directory.
  last_run_services_file: {{ user_config_dir }}/last-run-services

  # Script which starts / stops user services
  script_path: /opt/user-service-manager/manage-user-services.sh