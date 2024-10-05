# Installs the uv package manager (https://docs.astral.sh/uv/)
uv_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.uv.pkgs }}
