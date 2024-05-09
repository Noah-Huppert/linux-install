# Installs Unreal Engine
unreal_engine_multi_pkgs:
  multipkg.installed:
    - pkgs: {{ pillar.unreal_engine.multi_pkgs }}

{{ pillar.unreal_engine.dir }}:
  file.directory:
    - user: noah
    - group: noah
    - mode: 777
    - recurse:
      - user
      - group
    - requires:
      - pkg: unreal_engine_multi_pkgs
