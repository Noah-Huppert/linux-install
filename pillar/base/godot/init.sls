{% set version = '4.1' %}
{% set channel = 'stable'%}

godot:
  godot_dl:
    url: https://github.com/godotengine/godot/releases/download/{{ version }}-{{ channel }}/Godot_v{{ version }}-stable_mono_linux_x86_64.zip
    sha256sum: 35d295af7e3d87967850cf407867c2b213deb3f10a436e4afa4ee753a9474ef8

  install_dir: /opt/godot

  bin:
    target: /opt/godot/Godot_v{{ version }}-{{ channel }}_mono_linux_x86_64/Godot_v{{ version }}-{{ channel }}_mono_linux.x86_64
    desktop: /usr/local/share/applications/godot.desktop