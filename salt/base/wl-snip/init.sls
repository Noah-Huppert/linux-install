# Installs the wl-snip script to take screenshots on Wayland
wl_snip_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.wl_snip.pkgs }}
  
{{ pillar.wl_snip.install_path }}:
  file.managed:
    - source: salt://wl-snip/wl-snip
    - mode: 755
