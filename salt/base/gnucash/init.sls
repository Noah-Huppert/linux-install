# Installs GNU Cash

gnucash:
  pkg.installed:
    - pkgs: {{ pillar.gnucash.pkgs }}