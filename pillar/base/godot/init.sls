godot:
  xbps_godot_pkgs:
    - mono
    - mono-devel
    - msbuild-bin

  godot_dl:
    url: https://downloads.tuxfamily.org/godotengine/3.4.4/mono/Godot_v3.4.4-stable_mono_x11_64.zip
    sha256sum: ec622859b5ab70fcf1f9781c34e30d55a5d7bdc37926f1334c2cd0a3e4d4a776

  install_dir: /opt/godot

  bin:
    target: /opt/godot/Godot_v3.4.4-stable_mono_x11_64/Godot_v3.4.4-stable_mono_x11.64
    desktop: /usr/local/share/applications/godot.desktop
