# Installs Python
python_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.python.pkgs }}