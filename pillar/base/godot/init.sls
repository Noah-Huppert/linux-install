{% set version = '3.5' %}

godot:
  xbps_godot_pkgs:
    - mono
    - mono-devel
    - msbuild-bin

  godot_dl:
    url: https://downloads.tuxfamily.org/godotengine/{{ version }}/mono/Godot_v{{ version }}-stable_mono_x11_64.zip
    sha256sum: ad0ca1bdf822a9af353f17f8373dbfd32862e55ca9f8230dc752b7840656b89e

  install_dir: /opt/godot

  bin:
    target: /opt/godot/Godot_v{{ version }}-stable_mono_x11_64/Godot_v{{ version }}-stable_mono_x11.64
    desktop: /usr/local/share/applications/godot.desktop
