# Installs openjdk8-jre
java_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.java.pkgs }}
