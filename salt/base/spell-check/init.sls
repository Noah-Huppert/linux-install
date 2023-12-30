# Installs spell check utilities
spell_check_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.spell_check.pkgs }}
