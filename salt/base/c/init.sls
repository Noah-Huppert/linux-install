# Install C development environment.

c_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.c.pkgs }}
