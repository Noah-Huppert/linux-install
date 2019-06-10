{% set polybar_dir = '/home/noah/.config/polybar' %}

polybar:
  # Package
  pkg: polybar
  
  # Script to launch Polybar
  launch_script_file: {{ polybar_dir }}/launch.sh

  # Configuration file
  config_file: {{ polybar_dir }}/config

  # Network interface of which to show status
  network_interfaces:
    ethernet: enp59s0u2
    wireless: wlp2s0
