# Installs Tailscale

tailscale_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.tailscale.pkgs }}