{% set version = '4.0' %}
{% set channel = 'beta3'%}
{% set channel_path_prefix = '/beta3'%}

godot:
  xbps_godot_pkgs: []
    {# - mono
    - mono-devel
    - msbuild-bin #}

  godot_dl:
    url: https://downloads.tuxfamily.org/godotengine/{{ version }}{{ channel_path_prefix }}/mono/Godot_v{{ version }}-{{ channel }}_mono_linux_x86_64.zip
    sha256sum: 93b993cd6404bd36da856c706df84865db9fbee3c0138858768183f065a39431

  install_dir: /opt/godot

  bin:
    target: /opt/godot/Godot_v{{ version }}-{{ channel }}_mono_linux_x86_64/Godot_v{{ version }}-{{ channel }}_mono_linux.x86_64
    desktop: /usr/local/share/applications/godot.desktop