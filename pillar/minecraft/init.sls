{% set dir = '/opt/minecraft' %}

minecraft:
  # Minecraft launcher
  archive_url: https://launcher.mojang.com/download/Minecraft.tar.gz
  archive_file: {{ dir }}/Minecraft.tar.gz
  archive_256sum: 2f888fb423133c48c987408581ff0bddfb8eb79115c9796ccc1c28167146cc20

  # Directory everything is installed
  install_dir: {{ dir }}

  # Directory which mods are placed in
  mods_dir: {{ dir }}/mods

  # Custom script used to setup mods then launch minecraft
  launcher_script: /usr/local/bin/Minecraft

  # Actual minecraft launcher binary
  launcher_bin: {{ dir }}/minecraft-launcher/minecraft-launcher

  # Mods
  # Items have keys:
  #     - source_url: URL of mod file
  #     - source_256sum: SHA 256 hash of mod file
  #     - dest: Output name for file, placed in mods_dir
  #     - install: Install method for mod, can be:
  #         - jar: Indicates dest file should be run as a jar when the user runs
  #                the launcher script. Only run once.
  #         - copy-mods: Copies dest file to user's mods directory.
  #         - copy-shaders: Copies dest file to the user's shaders directory.
  #     - install_flag_file: Required if install==jar, used to track that the
  #                          mod jar has been run. Just name of a file.
  mods:
    # Forge - base mod platform
    - source_url: https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.15.2-31.2.0/forge-1.15.2-31.2.0-installer.jar
      source_256sum: a740c2d4e9fccef65c51ca2c2d5041159c04efc461dc73bbca691e87bd319ba4
      dest: forge-installer.jar
      install: jar
      install_flag_file: forge

    # World Edit - Copy paste
    - source_url: https://media.forgecdn.net/files/2873/556/worldedit-forge-mc1.15.2-7.1.0.jar
      source_256sum: 9e60225fb9bf950d4200184867442f56841d030a4983fe8b1f9bcd108269b41f
      dest: world-edit.jar
      install: copy-mods

    # Optifine - Requirement for shaders
    - source_url: https://optifine.net/downloadx?f=preview_OptiFine_1.15.2_HD_U_G1_pre18.jar&x=59d4f76d0926bc2d6dfd6a79afdb8d18
      source_256sum: 7a431d107092960a29372c1cd0a3009c47d54ad59faa81d996c6a1392e5c47f6
      dest: optifine.jar
      install: copy-mods
      install_flag_file: optifine

    # Sildurs Vibrant Shader (Medium) - Better looking Minecraft
    - source_url: http://download1608.mediafire.com/dhktz1cqu6eg/fm3m05j240b6ywo/Sildur%5C%27s+Vibrant+Shaders+v1.27+Medium.zip
      source_256sum: f2130f419ba5241d3291a624a7ef8291aeec1dc03e4c254f72ab00f7c14033f2
      dest: Sildurs-Vibrant-Shaders-Medium.zip
      install: copy-shaders
      
    # Sildurs Vibrant Shader (Light) - Better looking Minecraft
    - source_url: http://download1489.mediafire.com/z6dyqrtd4ggg/sklp0fgipb3a1kk/Sildur%5C%27s+Vibrant+Shaders+v1.27+Lite.zip
      source_256sum: cc319f5ad7716ce1148a8b5a63f46eb897c290088db7ebaa51a3539b6544cc41
      dest: Sildurs-Vibrant-Shaders-Light.zip
      install: copy-shaders
        
