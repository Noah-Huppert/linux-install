# Installs Tailscale

tailscale_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.tailscale.pkgs }}

{{ pillar.tailscale.service }}:
  service.running:
    - enable: True
    - requires:
      - pkgs: tailscale_pkgs