user_services:
  # Name of user service directory inside their home directory
  home_dir: .sv

  # Base name of runit service, "-$USER" is appended to the end
  base_svc: runsvdir

  # User service helper script install location
  helper_install: /usr/local/bin/usv
