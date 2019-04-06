{% set polybar_dir = '/etc/noah/.config/polybar' %}

rice:
  # Rice tool XBPS packages
  xbps_pkgs:
    # Set background
    - feh

    # Application launcher
    - rofi

    # Fonts
    - font-hack-ttf
    - fonts-roboto-ttf
    - nerd-fonts-ttf

  # Rice tool Python 3 packages
  python3_pkgs:
    # Theme based on wallpaper colors
    - pywal

  # Image
  images:
    # Background image
    - dog-flowers.jpg
 
    # Lock image
    # Credit: https://www.reddit.com/r/space/comments/arer0k/i_took_nearly_50000_images_of_the_night_sky_to/
    - moon-center.png

  # Directory to store images in
  images_directory: /home/noah/pictures