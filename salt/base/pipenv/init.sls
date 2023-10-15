# Installs Pipenv the Python virtual environment manager
pipenv_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.pipenv.pkgs }}