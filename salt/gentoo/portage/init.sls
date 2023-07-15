# Configures portage

{% for pkg in pillar['portage']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{{ pillar.portage.base_dir }}/{{ pillar.portage.make_file }}:
  file.managed:
    - source: salt://portage/make.conf

{{ pillar.portage.base_dir }}/{{ pillar.portage.pkg_use_dir }}:
  file.recurse:
    - source: salt://portage/package.use/
    - clean: true

{{ pillar.portage.base_dir }}/{{ pillar.portage.pkg_accept_keywords_dir }}:
  file.recurse:
    - source: salt://portage/package.accept_keywords/
    - clean: true

{{ pillar.portage.base_dir }}/{{ pillar.portage.pkg_license_file }}:
  file.managed:
    - source: salt://portage/package.license

rm_repos_conf_file:
  cmd.run:
    - name: rm {{ pillar.portage.base_dir }}/{{ pillar.portage.repos_dir }}
    - unless: '[[ ! -f {{ pillar.portage.base_dir }}/{{ pillar.portage.repos_dir }} ]]'

{{ pillar.portage.base_dir }}/{{ pillar.portage.repos_dir }}:
  file.recurse:
    - source: salt://portage/repos.conf
    - makedirs: true
    - clean: true
    - requires:
      - cmd: rm_repos_conf_file
