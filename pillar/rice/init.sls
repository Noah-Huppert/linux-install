{% set polybar_dir = '/etc/noah/.config/polybar' %}

rice:
  # Rice tool packages
  pkgs:
    # Set background
    - feh

    # Application launcher
    - rofi

    # Fonts
    - font-hack-ttf
    - fonts-roboto-ttf
    - nerd-fonts-ttf

  # Image
  images:
    # Background image
    - dog-flowers.jpg
 
    # Lock image
    - moon-center.png

  # Directory to store images in
  images_directory: /home/noah/pictures