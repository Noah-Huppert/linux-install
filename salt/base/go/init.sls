# Install Go

go_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.go.pkgs }}
