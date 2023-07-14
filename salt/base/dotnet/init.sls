# Installs .NET SDK

pkg_dotnet:
  pkg.installed:
    - pkgs: {{ pillar.dotnet.pkgs }}