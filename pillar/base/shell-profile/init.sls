shell_profile:
  # Script to assemble all shell units into one file
  bake_script: /opt/bake-profiles/bake-profiles.sh

  # Directory in user's home directory to store raw shell units
  shell_profiles_dir: .profile.d

  # File which indicates which shell units to include
  units_file: .profile.units

  # Shell units to include in the units_file
  shell_units:
    - meta_fns.sh
    - usr_local_bin.sh
    - editor.sh
    #- terminal.sh
    - pager.sh
    - browser.sh
    - screenshot_dir.sh
    - gpg_tty.sh
    - gpg2_alias.sh
    - gpg_import.sh
    - xdg_config_home.sh
    - ssh_agent.sh
    # - history.sh # Not need for ansi-term bash
    - go.sh
    - rust.sh
    - deno.sh
    - prompt.sh
    - ls_color.sh
    - shell_reload_fn.sh
    - user_bin.sh
    - scripts_fns.sh
    - org_mode.sh
    - trash.sh
    - edit_alias.sh
    - salt_apply_alias.sh
    - autocd.sh
    - kubectl_alias.sh
    - kube_namespace.sh
    - git_alias.sh
    - android_sdk.sh
    - autostart.sh
    - linux_install_edit.sh
    #- startx.sh
    - start_wayland.sh
