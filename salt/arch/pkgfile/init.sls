# Install pkgfile
pkgfile_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.pkgfile.pkgs }}
