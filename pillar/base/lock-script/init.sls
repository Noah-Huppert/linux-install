lock_script:
  # Lock script file
  file: /bin/lock

  # Sudoer configuration file
  sudo_config_file: /etc/sudoers.d/lock

  # Lock screen background image
  background_image: /home/noah/pictures/moon-center.png

  # Required packages for script to function
  pkgs:
    - xsecurelock
    - xscreensaver
