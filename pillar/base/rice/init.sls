{% set background_img = 'dog-flowers.jpg' %}

rice:
  # Rice packages
  os_pkgs: []

  # Rice tool Python 3 packages
  python3_pkgs: []

  # Image
  images:
    # Background image
    - {{ background_img }}
 
    # Lock image
    # Credit: https://www.reddit.com/r/space/comments/arer0k/i_took_nearly_50000_images_of_the_night_sky_to/
    - moon-center.png

  background_img: {{ background_img }}

  # Directory to store images in
  images_directory: /usr/share/pictures