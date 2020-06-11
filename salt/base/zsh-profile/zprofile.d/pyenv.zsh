# Adds pyenv to the PATH
export PYENV_ROOT="$HOME/{{ pillar.pyenv.install_dir }}/{{ pillar.pyenv.install_subdir }}"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
