# Install Hugo static site generator
hugo_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.hugo.pkgs }}
