# Installs Qemu
qemu_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.qemu.pkgs }}
