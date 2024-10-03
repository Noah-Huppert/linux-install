# Installs iPerf https://iperf.fr/
iperf_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.iperf.pkgs }}
