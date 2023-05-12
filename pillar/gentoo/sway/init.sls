sway:
  waybar_modules:
    left:
      - sway/workspaces
      - sway/mode

    center:
      - wireplumber
      - backlight
      - network
      - custom/vpn

    right:
      - disk
      - battery
      - clock
  
  pkgs:
    - gui-wm/sway
    - gui-apps/waybar
    - x11-misc/rofi
