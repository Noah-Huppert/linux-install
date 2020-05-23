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
  #         - copy: Copies dest file to user's mods directory.
  #     - install_flag_file: Required if install==jar, used to track that the
  #                          mod jar has been run. Just name of a file.
  mods:
    - source_url: https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.15.2-31.2.0/forge-1.15.2-31.2.0-installer.jar
      source_256sum: a740c2d4e9fccef65c51ca2c2d5041159c04efc461dc73bbca691e87bd319ba4
      dest: forge-installer.jar
      install: jar
      install_flag_file: forge
    - source_url: https://media.forgecdn.net/files/2873/556/worldedit-forge-mc1.15.2-7.1.0.jar
      source_256sum: 9e60225fb9bf950d4200184867442f56841d030a4983fe8b1f9bcd108269b41f
      dest: world-edit.jar
      install: copy
