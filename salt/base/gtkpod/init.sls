# Installs GTKPod (https://en.wikipedia.org/wiki/Gtkpod) a GTK based iPod library manager
gtkpod_pkgs:
  multipkg.installed:
    - pkgs: {{ pillar.gtkpod.multipkgs }}
