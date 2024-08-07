# Installs Doom emacs (https://github.com/doomemacs/doomemacs)
doom_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.doom_emacs.pkgs }}

{% for user_name, user in pillar['users']['users'].items() %}
{% for repo_name, repo in pillar['doom_emacs']['repos'].items() %}
{{ user_name }}_{{ repo_name }}_repo_cloned:
  git.cloned:
    - name: {{ repo['git'] }}
    - branch: {{ repo['branch'] }}
    - target: {{ user['home'] }}/{{ repo['home_relative_target'] }}
    - user: {{ user['name'] }}
{% endfor %}
{% endfor %}
