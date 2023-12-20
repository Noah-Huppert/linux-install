# Install salt-lint
salt_lint_aur_pkgs:
  aurpkg.installed:
    - pkgs: {{ pillar.salt_lint.aur_pkgs }}
