zsh_profile:
  # Script to assemble all zsh units into one file
  bake_script: /opt/bake-zprofiles/bake-zprofiles.sh

  # Directory in user's home directory to store raw zsh units
  zsh_profiles_dir: .zprofile.d

  # File which indicates which zsh units to include
  units_file: .zprofile.units

  # Zsh units to include in the units_file
  zsh_units:
    - meta_fns.zsh
    - editor.zsh
    - terminal.zsh
    - pager.zsh
    - screenshot_dir.zsh
    - gpg_tty.zsh
    - gpg2_alias.zsh
    - gpg_import.zsh
    - xdg_config_home.zsh
    - ssh_agent.zsh
    - emacs_keys.zsh
    - history.zsh
    - go.zsh
    - rust.zsh
    - prompt.zsh
    - ls_color.zsh
    - zsh_reload_fn.zsh
    - user_bin.zsh
    - scripts_fns.zsh
    - org_mode.zsh
    - trash.zsh
    - edit_alias.zsh
    - salt_apply_alias.zsh
    - autocd.zsh
    - kubectl_alias.zsh
    - kube_namespace.zsh
    - git_alias.zsh
    - android_sdk.zsh
    - autostart.zsh
    - linux_install_edit.zsh
    - tmux.zsh
    - startx.zsh
