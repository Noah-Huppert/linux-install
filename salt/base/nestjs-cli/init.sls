# Installs @nestjs/cli from npm.
# src=SRC
{% for pkg in pillar['nestjs_cli']['npm_nestjs-cli_pkgs'] %}
nestjs_cli_install_{{ loop.index0 }}:
  npm.installed:
    - name: "{{ pkg }}"
{% endfor %}
