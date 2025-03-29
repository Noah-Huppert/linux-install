# Install the korganizer calendar app
korganizer_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.korganizer.pkgs }}
