# Installs the gohls downloader tool.

{% for _, user in pillar['users']['users'].items() %}
get_go_hls_{{ user.name }}:
  cmd.run:
    - name: GOPATH={{ pillar.go.go_substitute_path }} go get {{ pillar.gohls.repo }}
    - unless: test -f {{ pillar.go.go_substitute_path}}/bin/{{ pillar.gohls.bin }}
    - runas: {{ user.name }}
{% endfor %}
