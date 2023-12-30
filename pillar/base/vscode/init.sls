vscode:
  pkgs: []
  pkgs_state: pkg

  # Initial user settings
  # Required for the first launch of VSCode in Wayland so it doesn't crash
  # Salt state will allow this file to be overridden so user can then customize their settings outside of Salt
  user_settings_file: .config/Code/User/settings.json

  # Application desktop files
  oss_desktop_file: null # /usr/share/applications/code-oss.desktop
  msfs_desktop_file: null # /usr/share/applications/code.desktop
