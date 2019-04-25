{% set polybar_dir = '/home/noah/.config/polybar' %}

polybar:
  # Package
  pkg: polybar
  
  # Script to launch Polybar
  launch_script_file: {{ polybar_dir }}/launch.sh

  # Configuration file
  config_file: {{ polybar_dir }}/config
